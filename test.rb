require 'mini_magick'
photo_paths = Dir['data/*']

def to_kb(bytes)
  "#{(bytes / (1024.0)).round}Kb"
end

photo_paths.each do |p_path|
  path = Pathname.new(p_path)
  file_name = path.basename

  image = MiniMagick::Image.open(path)
  before = to_kb(image.size)
  image.resize('600x600')
  after = to_kb(image.size)
  image.format('jpg')

  thumb_name = "output/thumb_#{file_name}"
  saving_str = "saving: #{thumb_name}".ljust(50)
  puts "#{saving_str} before: #{before}\tafter:#{after}"
  image.write(thumb_name)
end
