class Services::GovboxController < ContentController
  layout 'application_bs4'

  PARAMS = [
    :legal_subject_name, :cin, :formatted_address,
    :first_name, :surname, :pin, :person_formatted_address,
    :email, :phone, :postal_address, :snailmail,
    :password, :password_confirmation
  ]

  def index
    @page.title = 'Jednoduchý prístup k štátnej elektronickej schránke &middot; GovBox'.html_safe
    @page.og.image = view_context.image_url('services/govbox/facebook_share.png')
    @page.og.description = 'Jednoduchý prístup k štátnej elektronickej schránke priamo cez Váš email a bez elektronického občianskeho preukazu. Od Slovensko.Digital.'
  end

  def register_step1
    @page.title = 'Jednoduchý prístup k štátnej elektronickej schránke &middot; GovBox'.html_safe
    @page.og.image = view_context.image_url('services/govbox/facebook_share.png')
    @page.og.description = 'Jednoduchý prístup k štátnej elektronickej schránke priamo cez Váš email a bez elektronického občianskeho preukazu. Od Slovensko.Digital.'
  end

  def register_step2; end

  def register_step3; end

  def register_step4; end

  def register_step5
    RestClient.post(ENV.fetch('GOVBOX_FORM_ENDPOINT'), params.permit(PARAMS).to_h)
    redirect_to register_thanks_services_govbox_index_path
  end

  def register_thanks; end
end
