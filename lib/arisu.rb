# frozen_string_literal: true

require 'dotenv'
require 'google-cloud-secret_manager'
require_relative 'arisu/dotenv_inject'
require_relative 'arisu/version'

module Arisu
  GCP_ENV_KEYS = %w[
    GOOGLE_CLOUD_PROJECT
    GOOGLE_CLOUD_CREDENTIALS
    GOOGLE_CLOUD_KEYFILE
    GCLOUD_KEYFILE
    GOOGLE_CLOUD_CREDENTIALS_JSON
    GOOGLE_CLOUD_KEYFILE_JSON
    GCLOUD_KEYFILE_JSON
  ].freeze

  class << self
    def load(*filenames, secret_manager: nil, project_id: nil)
      env = Dotenv.parse(*filenames)
      GCP_ENV_KEYS.each {|e| ENV[e] ||= env[e] if env.key?(e)}
      decrypt!(env, secret_manager: secret_manager, project_id: project_id)
      env.each {|k, v| ENV[k] ||= v}
    end

    def load!(*filenames, secret_manager: nil, project_id: nil)
      env = Dotenv.parse!(*filenames)
      GCP_ENV_KEYS.each {|e| ENV[e] ||= env[e] if env.key?(e)}
      decrypt!(env, secret_manager: secret_manager, project_id: project_id)
      env.each {|k, v| ENV[k] ||= v}
    end

    def overload(*filenames, secret_manager: nil, project_id: nil)
      env = Dotenv.parse(*filenames)
      GCP_ENV_KEYS.each {|e| ENV[e] = env[e] if env.key?(e)}
      decrypt!(env, secret_manager: secret_manager, project_id: project_id)
      env.each {|k, v| ENV[k] = v}
    end

    def overload!(*filenames, secret_manager: nil, project_id: nil)
      env = Dotenv.parse!(*filenames)
      GCP_ENV_KEYS.each {|e| ENV[e] = env[e] if env.key?(e)}
      decrypt!(env, secret_manager: secret_manager, project_id: project_id)
      env.each {|k, v| ENV[k] = v}
    end

    private

    def decrypt!(env, secret_manager: nil, project_id: nil)
      secret_manager ||= Google::Cloud::SecretManager.secret_manager_service
      project_id ||= ENV['GOOGLE_CLOUD_PROJECT']

      env.transform_values! do |v|
        next v unless v.size >= 9 && v[0, 7] == ':arisu:' && v[-1] == ':'

        _empty, _arisu, this_project_id, key, version = v.split(':')

        unless version
          version = key
          key = this_project_id
          this_project_id = project_id
        end

        raise 'project ID not specified' if !this_project_id || this_project_id.empty?

        name = secret_manager.secret_version_path(
          project: this_project_id,
          secret: key,
          secret_version: version || 'latest'
        )
        secret_manager.access_secret_version(name: name).payload.data
      end
    end
  end
end
