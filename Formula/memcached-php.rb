require 'formula'

class MemcachedPhp < Formula
  homepage 'http://pecl.php.net/package/memcached'
  url 'http://pecl.php.net/get/memcached-2.0.1.tgz'
  md5 'f81a5261be1c9848ed5c071a4ebe5e05'
  head 'https://github.com/php-memcached-dev/php-memcached.git'

  depends_on 'autoconf'
  depends_on 'libmemcached'
  depends_on 'igbinary-php' if ARGV.include? '--with-igbinary-support'
  
  def options
    [
      ['--with-igbinary-support', 'Include support for serializing through igbinary lib']
    ]
  end

  def install
    if not ARGV.build_head?
      cd "memcached-#{version}"
    end

    args = [
      "--prefix=#{prefix}",
      "--with-libmemcached-dir=#{Formula.factory('libmemcached').prefix}"
    ]
    
    if ARGV.include? '--with-igbinary-support'
      args << '--enable-memcached-igbinary'
    end

    system "phpize"
    system "./configure", *args
    system "make"
    prefix.install 'modules/memcached.so'
  end

  def caveats; <<-EOS.undent
    To finish installing memcached-php:
      * Add the following line to #{etc}/php.ini:
        extension="#{prefix}/memcached.so"
      * Restart your webserver.
      * Write a PHP page that calls "phpinfo();"
      * Load it in a browser and look for the info on the memcached module.
      * If you see it, you have been successful!
    EOS
  end
end
