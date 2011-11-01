module FrontMatter

  REGEX   = /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
  INSPECT = 13
  PARSER  = Psych

  # Quick check to discover if a file might have frontmatter in it.
  # Only checks if the first line starts with "---"
  #
  # path_to_file - the canonical path the the file
  #
  # Returns boolean
  def self.file_might_have_frontmatter?(path_to_file)
    File.open(path_to_file){|f| f.readline}[0..2] == '---'
  end

  # A more definitive check to find if a file has frontmatter in it.
  # Since we are reading the file, we want to be cautious with with
  # memory and only check LINES_TO_INSPECT
  #
  # path_to_file - the canonical path to the file
  #
  # Returns boolean
  def self.file_has_frontmatter?(path_to_file)
    IO.readlines(path_to_file,INSPECT).join =~ REGEX ? true : false
  end

  # Check if the text has front matter
  #
  # text - the string to check
  #
  # Returns boolean
  def self.has_frontmatter?(text)
    text =~ REGEX 
  end

  # Parse the YAML frontmatter.
  #
  # text - The String path to the frontmatter and the content.
  #
  # Returns a hash containing the parsed frontmatter data and the content.
  def self.parse(text)

    document = Hash.new 

    if text =~ REGEX 

      document[:content] = $POSTMATCH

      begin
        document.merge!(PARSER.load($1))
      rescue => e
        puts "YAML Exception reading #{name}: #{e.message}"
      end

    end

    document

  end

end
