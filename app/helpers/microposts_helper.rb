module MicropostsHelper
  def display_image(micropost)
    if micropost.image.attached?
      micropost.image.variant(resize_to_limit: [500, 500])
    end
  end
end
