class PositiveCodeCounter::FileInfo

  REGEXP_FOR_IGNORED_ROWS = /\A[ \t]*(?:end)*\Z/
  MAX_FILENAME_LENGTH = 108

  def initialize( filename )
    @filename = filename
    set_rows
  end

  attr_reader :filename
  attr_reader :rows

  def to_s
    @filename + " " + "." * number_of_separator + " " + @rows.to_s.rjust(4)
  end

  private

  def set_rows
    @rows = ::File.open( @filename , "r:utf-8" ).read.split( /\n/ ).delete_if { | row |
      REGEXP_FOR_IGNORED_ROWS === row
    }.length
  end

  def number_of_separator
    [ 0 , ( MAX_FILENAME_LENGTH - @filename.length ) ].max
  end

end
