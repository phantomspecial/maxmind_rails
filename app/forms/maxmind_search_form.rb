class MaxmindSearchForm
  include ActiveModel::Model
  attr_accessor :ip_addresses

  HEADER = %w(IP ISO_CODE)

  validates :ip_addresses, presence: true

  def search
    ips = ip_addresses.split(',')
    mmdb = Maxmind.new
    results = []

    ips.each do |ip|
      ip = ip.gsub(/\R/, '').delete('"').strip
      mmdb.ip = ip
      iso_code = valid_ip?(ip) ? mmdb.iso_code : 'Invalid IP'

      results << {
          ip: ip,
          iso_code: iso_code
      }
    end

    results
  end

  def filename
    ['Maxmind_IP_Addresses', Time.current, '.csv'].join
  end

  private

  def valid_ip?(ip)
    !!IPAddr.new(ip) rescue false
  end
end