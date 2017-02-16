require 'mini_magick'
photo_paths = Dir['data/*']

photo_paths.each do |p_path|
  path = Pathname.new(p_path)
  file_name = path.basename
  image = MiniMagick::Image.open(path)
  image.resize('600x600')
  image.format('jpg')
  image.write("thumb_#{file_name}")
end
