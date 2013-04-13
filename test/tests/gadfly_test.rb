require 'minitest/autorun'
require 'turn'
require 'selenium-webdriver'
Turn.config.format = :pretty

LOG_FILE = '/var/log/upstart/foobar.log'

class GadflyTest < MiniTest::Unit::TestCase
  # TODO find a wait function that doesnt depend on selenium
  def wait_until
    Selenium::WebDriver::Wait.new(timeout: 10).until do
      begin
        yield
      rescue
        false
      end
    end
  end

  def test_gadfly
    Dir.chdir('test')
    system("sudo rm #{LOG_FILE}") if File.exists?(LOG_FILE)
    assert_equal(true, `../bin/gadfly foobar`.include?('foobar start/running, process'))

    wait_until { File.exists?(LOG_FILE) }
    assert_equal('foobar', `sudo cat #{LOG_FILE}`.chomp)
  end
end