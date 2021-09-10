# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.paginate(page, per_page)
    upper_limit = (page * per_page) - 1
    lower_limit = upper_limit - per_page + 1
    objects = self.all

    (lower_limit..upper_limit).map do |n|
      objects[n]
    end.compact
  end
end
