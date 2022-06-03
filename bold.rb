# frozen_string_literal: true

# Run this operation on all children of the directory this file is in.
#
# __dir__ => directory this file is in
# __FILE__ => name of this file
Dir.each_child(__dir__) do |entry|
  # Skip this file and all directories.
  next if File.directory?(entry)
  next if File.basename(entry) == File.basename(__FILE__)

  # Get the text from the file.
  # doc => String
  doc = File.read entry

  # This will contain a list of all the processed words.
  # bolded_doc => Array
  bolded_doc = []

  # Bold the first 2 letters in Markdown format, accounting for 1 letter words and punctuation.
  doc.split.each do |word|
    bolded_doc << if word.delete('^a-zA-Z0-9').length > 1
                    word.insert(2, '**').insert(0, '**')
                  else
                    word.insert(1, '**').insert(0, '**')
                  end
  end

  Dir.mkdir 'output' unless File.exist? 'output'

  # Write the new processed string to a markdown file with the same name as the input file.
  # bolded_doc.join => String
  File.write(File.join(__dir__, 'output', File.basename(entry, '.*').concat('.md')), bolded_doc.join(' '))
end
