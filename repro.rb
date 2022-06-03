#!/usr/bin/env ruby

require 'get_process_mem'
require 'google/protobuf'

$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'opentelemetry/proto/trace/v1/trace_pb'

def main
  # Run once to prove this isn't just about lazy loading or something
  make_spans_with_leak(1)
  make_spans_with_no_leak(1)
  GC.start
  GC.compact
  puts "RSS before: #{GetProcessMem.new.mb} mb"

  # I'm not actually sure this makes a difference but it's what I initially tested with
  kept_scope_objects = []

  # Alternate a few times to make the pattern clear
  3.times do
    make_spans_with_no_leak(1000)
    GC.start
    GC.compact
    puts "RSS after less-leaky version: #{GetProcessMem.new.mb} mb"

    kept_scope_objects << make_spans_with_leak(1000)
    GC.start
    GC.compact
    puts "RSS after leaky version: #{GetProcessMem.new.mb} mb"
  end
end

def make_spans_with_leak(iters)
  # Note the `freeze`, just to verify the leaky reference is being grabbed
  # somewhere Ruby doesn't see
  scope = Opentelemetry::Proto::Common::V1::InstrumentationScope.new.freeze
  iters.times do
    spans = iters.times.map {Opentelemetry::Proto::Trace::V1::Span.new}
    Opentelemetry::Proto::Trace::V1::ScopeSpans.new(scope: scope, spans: spans)
  end
  scope
end

def make_spans_with_no_leak(iters)
  iters.times do
    # Note moving `scope` inside is the only difference
    scope = Opentelemetry::Proto::Common::V1::InstrumentationScope.new.freeze
    spans = iters.times.map {Opentelemetry::Proto::Trace::V1::Span.new}
    Opentelemetry::Proto::Trace::V1::ScopeSpans.new(scope: scope, spans: spans)
  end
end

if $PROGRAM_NAME == __FILE__
  main()
end
