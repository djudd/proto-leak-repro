# proto-leak-repro

Run `bundle exec repro.rb` to see the issue. For me, this produces output like:

```
RSS before: 26.2265625 mb
RSS after less-leaky version: 52.6640625 mb
RSS after leaky version: 422.6171875 mb
RSS after less-leaky version: 455.24609375 mb
RSS after leaky version: 795.4140625 mb
RSS after less-leaky version: 829.08984375 mb
RSS after leaky version: 1166.67578125 mb
```

(This is a minimization of a leak we saw in a staging environment.)

The Proto classes used here were generated as follows:
```
protoc --proto_path=../opentelemetry-proto/ --ruby_out=. ../opentelemetry-proto/opentelemetry/proto/**/*.proto
```

where `../opentelemetry-proto` contained a checkout of `https://github.com/open-telemetry/opentelemetry-proto`.
