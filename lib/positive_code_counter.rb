require "positive_code_counter/version"
require "positive_code_counter/file_info"

class PositiveCodeCounter

  def self.process( filenames )
    self.new( filenames ).process
  end

  def initialize( filenames )
    @file_infos = filenames.map { | filename |
      ::PositiveCodeCounter::FileInfo.new( filename )
    }
  end

  def process
    @file_infos.each do | file_info |
      puts file_info.to_s
    end

    put_empty_row
    puts "#{ number_of_files } files, #{ all_rows } rows."
  end

  private

  def file_infos_sort_by_number_of_rows
    @file_infos.sort_by( &:rows )
  end

  def number_of_files
    @file_infos.length
  end

  def all_rows
    @file_infos.map( &:rows ).inject( :+ )
  end

end
