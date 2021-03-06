require 'formula'

class ApcPhp < Formula
  homepage 'http://pecl.php.net/package/apc'
  url 'http://pecl.php.net/get/APC-3.1.9.tgz'
  md5 'a2cf7fbf6f3a87f190d897a53260ddaa'
  
  devel do
    url 'http://pecl.php.net/get/APC-3.1.10.tgz'
    version '3.1.10'
    md5 'f4a6b91903d6ba9dce89fc87bb6f26c9'
  end

  depends_on 'autoconf'
  depends_on 'pcre'

  def install
    Dir.chdir "APC-#{version}" do
      system "phpize"
      system "./configure", "--prefix=#{prefix}", "--enable-apc-pthreadmutex"
      system "make"

      prefix.install %w(modules/apc.so apc.php)
    end
  end

  def caveats; <<-EOS.undent
    To finish installing apc-php:
      * Add the following lines to #{etc}/php.ini:
        [apc]
        extension="#{prefix}/apc.so"
        apc.enabled=1
        apc.shm_segments=1
        apc.shm_size=64M
        apc.ttl=7200
        apc.user_ttl=7200
        apc.num_files_hint=1024
        apc.mmap_file_mask=/tmp/apc.XXXXXX
        apc.enable_cli=1
      * Restart your webserver.
      * Write a PHP page that calls "phpinfo();"
      * Load it in a browser and look for the info on the apc module.
      * If you see it, you have been successful!
      * You can copy "#{prefix}/apc.php" to any site to see APC's usage.
    EOS
  end
end