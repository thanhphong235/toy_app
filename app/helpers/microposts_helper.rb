module MicropostsHelper
    # Trả về variant đã resize của ảnh Micropost
  def display_image(micropost, width: 500, height: 500)
    return unless micropost.image.attached?

    micropost.image.variant(resize_to_limit: [width, height])
  end
end
