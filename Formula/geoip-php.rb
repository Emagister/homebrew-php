require 'formula'

class GeoipPhp < Formula
  homepage 'http://pecl.php.net/package/geoip'
  url 'http://pecl.php.net/get/geoip-1.0.8.tgz'
  # md5 '4ad53115ed7d1d452cbe50b45dcecdf2'

  depends_on 'libgeoip'
  depends_on 'autoconf'

  def install
    Dir.chdir "geoip-#{version}" do
      system "phpize"
      system "./configure", "--prefix=#{prefix}", '--with-geoip'
      system "make"

      prefix.install 'modules/igbinary.so'
    end
  end

  def caveats; <<-EOS.undent
    To finish installing igbinary-php:
      * Add the following lines to #{etc}/php.ini:
        [apc]
        extension="#{prefix}/igbinary.so"
        igbinary.compact_strings = Off

      * Restart your webserver.
      * Write a PHP page that calls "phpinfo();"
      * Load it in a browser and look for the info on the igbinary module.
      * If you see it, you have been successful!
    EOS
  end
end