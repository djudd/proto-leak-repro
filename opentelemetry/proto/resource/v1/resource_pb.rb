# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: opentelemetry/proto/resource/v1/resource.proto

require 'google/protobuf'

require 'opentelemetry/proto/common/v1/common_pb'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("opentelemetry/proto/resource/v1/resource.proto", :syntax => :proto3) do
    add_message "opentelemetry.proto.resource.v1.Resource" do
      repeated :attributes, :message, 1, "opentelemetry.proto.common.v1.KeyValue"
      optional :dropped_attributes_count, :uint32, 2
    end
  end
end

module Opentelemetry
  module Proto
    module Resource
      module V1
        Resource = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("opentelemetry.proto.resource.v1.Resource").msgclass
      end
    end
  end
end
