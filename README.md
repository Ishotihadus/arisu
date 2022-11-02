# Arisu

私が思っていたよりも…この世界には、素敵な魔法が溢れているんですね

Dotenv files integrated with google-cloud-secret_manager.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add arisu

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install arisu

## Usage

Create .env file with a format shown below.

```
DB_PASSWORD=:arisu:db-password:
#  signature ^^^^^
#                  ^^^^^^^^^^^ secret name

DB_PASSWORD=:arisu:db-password:latest:
#                              ^^^^^^ version (optional)

DB_PASSWORD=:arisu:to-you-for-me:db-password:latest:
#                  ^^^^^^^^^^^^^ project ID (optional)
```

You can load this .env file by calling `Arisu.load` or loading `arisu/load`.

The usage of this library is similar to Dotenv. Please refer to the documentation of Dotenv.

### Google Cloud Secret Manager Configuration

Arisu requires configuration of Google Cloud Secret Manager.

You can configure it by adding one of these environment variables: 
`GOOGLE_CLOUD_CREDENTIALS`, `GOOGLE_CLOUD_KEYFILE`, `GCLOUD_KEYFILE`, `GOOGLE_CLOUD_CREDENTIALS_JSON`, `GOOGLE_CLOUD_KEYFILE_JSON`, `GCLOUD_KEYFILE_JSON`.

You can specify default project ID by setting `GOOGLE_CLOUD_PROJECT`.

These environment variables can be set also in .env files.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Ishotihadus/arisu.
