ActiveAdmin.register Book do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :author_id, :average_rating, :page_count, :title, :isbn, :price, :image
  #
  # or
  #
  # permit_params do
  #   permitted = [:author_id, :average_rating, :page_count, :title, :isbn, :price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image.variant(resize_to_limit: [200,200])) : nil
    end
    f.actions
  end
end
