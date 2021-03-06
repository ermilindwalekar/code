#!/usr/bin/env ruby -wKU
#-*- coding:utf-8 -*-

require "json"
require "pp"

################################################################################
#
#
#
################################################################################
class String
  def korean?
    self.index(/\p{Hangul}/) != nil
  end 

  def has_korean?
    self.korean?
  end 

  def extract_korean
    b, e = self.index(/\p{Hangul}/), self.rindex(/\p{Hangul}/)
    (b != nil) ? self[b, e - b + 1] : ""
  end 
end

################################################################################
#
#
#
################################################################################
class MDDictionary
  TABLE = { :eng => 0, :jpn => 1 }
  DIR   = { :asc => 1, :dsc =>-1 }

  def initialize(file)
    @file = file
    @dict = sort(JSON.parse(File.read(file)).to_a)
  end

  def sort arr, dir=DIR[:dsc]
    arr.sort_by { |l| l[0].gsub(/\ +/, ' ').length * dir }
  end

  def ok?
    @dict.size > 0 
  end

  def to_english text
    translate_utf8 text, :eng
  end

  # index = 0 -> english
  def translate_utf8 text, index
    @dict.each { |word| 
      key, eng = word[0], word[1][TABLE[index]] 
      text.gsub!(key, eng)
    }
    text
  end

  def update key
    @dict << [key, ["",  ""]]
    @dict = sort(@dict)
  end

  def update_using file
    File.open(file, "r").each_line { |l|
      if l.has_korean?
        key = l.extract_korean
        @dict << [key, ["", ""]] unless self.has_same(key)
      end
    }
  end

  def has_same key
    @dict.each { |item| return true if item[0] == key }
    false
  end

  def save
    hash = {}; @dict.each { |item| hash[item[0]] = item[1] }

    File.open(@file, "w") { |f| f.write(JSON.pretty_generate(hash)) }
  end

  def print lang=:eng
    pp @dict
  end
end

################################################################################
#
#
#
################################################################################
class KoreanFile
  def initialize(filename, dict, encoding="utf-8")
    @filename = filename
    @utf8 = (encoding == "utf-8")
    @dict = dict
  end

  def to_english
    text = read_text
    @dict.to_english(text)
  end
  
  def read_text
    mode = @utf8 ? "r" : "r:utf-16le:utf-8"
    text = File.open(@filename, mode).read()
    text
  end
  
  def save text
    mode = @utf8 ? "w" : "w:utf-16le"
    File.open(@filename, mode) { |f| f.write(text) }
  end
  
  def backup text, ext="org"
    backup_name = "#{@filename}.#{ext}"
    unless File.exists?(backup_name)
      mode = @utf8 ? "w" : "w:utf-16le"
      File.open(backup_name, mode) { |f| f.write(text) }
    end
  end
end

################################################################################
#
#
#
################################################################################
if __FILE__ == $PROGRAM_NAME
  xaml_files = %w{
    Eng/CasePage.xaml
    Eng/EvidenceInfo.xaml
    Eng/EvidencePage.xaml
    Eng/RecentItemFormat.xaml
    Eng/RecentTsfFormat.xaml
    Eng/StartPage.xaml
    Eng/NewCaseNotice_InsufficientSpace.xaml
  }

  xml_files = %w{
    ../../ResourceDLL/BesmasterResEng/res/Dialogs.xml
    ../../ResourceDLL/BesmasterResEng/res/Logs.xml
    ../../ResourceDLL/BesmasterResEng/res/StringTable.xml
  }

  rc_files = %w{ 
    ../../ResourceDLL/BesmasterResEng/BesmasterResEng.rc 
  }

  dict = MDDictionary.new("dictionary.json")
  dict.print
  dict.update_using("korean_input.txt")
  dict.save


  # utf8_files = xaml_files + xml_files
  # utf8_files.each { |file| 
  #   f = KoreanFile.new(file, dict)
  #   text = f.to_english
  #   f.backup text
  #   f.save text
  # }

  # rc_files.each { |file| 
  #   f = KoreanFile.new(file, dict, "utf16-le")
  #   text = f.to_english
  #   puts text
  #   f.backup text
  #   f.save text
  # }
  
end
