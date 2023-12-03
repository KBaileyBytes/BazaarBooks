ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :province_id, :first_name, :last_name, :is_admin, :address, :phone, :postal_code
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :province_id, :first_name, :last_name, :is_admin, :address, :phone, :postal_code]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.semantic_errors
    f.inputs 'Details' do
      input :email
      input :first_name
      input :last_name
      input :is_admin
      input :province
      input :address
      input :phone
      input :postal_code
    end
    f.actions
  end

end
