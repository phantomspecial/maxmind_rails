# frozen_string_literal: true
class Maxmind
  include ActiveModel::Model
  attr_accessor :ip

  DB_FILE_PATH = Rails.root.join('db', 'GeoLite2-Country.mmdb')

  def initialize(attr = {})
    super(attr)
    @reader = MaxMind::GeoIP2::Reader.new(DB_FILE_PATH)
  end

  def search
    @reader.country(ip)
  end

  def iso_code
    search.country.iso_code
  end

  def jp?
    search.country.iso_code == 'JP'
  end
end
