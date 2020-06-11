ActiveAdmin.register Profile do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :slack_user_id, :github_id
  form do |f|
    f.inputs do
      f.input :slack_user_id
      f.input :github_id
    end
    f.actions
  end  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :name, :image, :belong_to, :message, :description, :twitter, :facebook, :web, :github, :place]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
