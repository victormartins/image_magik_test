require 'mini_magick'




class Test
  SIZES = [1200, 600]

  def initialize
    photo_paths = Dir['data/*']

    photo_paths.each do |p_path|
      path = Pathname.new(p_path)

      image = MiniMagick::Image.open(path)

      process(image, path)
    end
  end

  def process(image, path)
    file_name = path.basename
    original = image.dup
    before = to_kb(original.size)

    SIZES.each do |size|
      image.resize("#{size}x#{size}")
      image.format('jpg')
      after = to_kb(image.size)

      thumb_name = "output/#{size}_#{file_name}"
      saving_str = "saving: #{thumb_name}".ljust(60)
      puts "#{saving_str} before: #{before}\tafter:#{after}"
      image.write(thumb_name)
    end
  end

  def to_kb(bytes)
    "#{(bytes / (1024.0)).round}Kb"
  end
end

Test.new
