# frozen_string_literal: true

require 'dry-validation'

module ISSInternship
  # Form helpers
  module Form
    USERNAME_REGEX = /^[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*$/.freeze
    EMAIL_REGEX = /@/.freeze
    TITLE_REGEX = %r{^((?![&\/\\\{\}\|\t]).)*$}.freeze
    COMPNUM_REGEX = /[0-9]{8}/.freeze

    def self.validation_errors(validation)
      validation.errors.to_h.map { |k, v| [k, v].join(' ') }.join('; ')
    end

    def self.message_values(validation)
      validation.errors.to_h.values.join('; ')
    end
  end
end
