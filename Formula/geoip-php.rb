require 'formula'

class GeoipPhp < Formula
  homepage 'http://pecl.php.net/package/geoip'
  url 'http://pecl.php.net/get/geoip-1.0.8.tgz'
  md5 '65263ac6d1c335f22ce818b3253912a5'

  depends_on 'libgeoip'
  depends_on 'autoconf'

  def install
    Dir.chdir "geoip-#{version}" do
      system "phpize"
      system "./configure", "--prefix=#{prefix}", '--with-geoip'
      system "make"

      prefix.install 'modules/geoip.so'
    end
  end

  def caveats; <<-EOS.undent
    To finish installing geoip-php:
      * Add the following lines to #{etc}/php.ini:
        [apc]
        extension="#{prefix}/geoip.so"
        geoip.custom_directory = /path/to/your/GeoIP.dat/directory

      * Restart your webserver.
      * Write a PHP page that calls "phpinfo();"
      * Load it in a browser and look for the info on the igbinary module.
      * If you see it, you have been successful!
    EOS
  end
end