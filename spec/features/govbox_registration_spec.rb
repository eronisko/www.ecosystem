require 'rails_helper'

RSpec.feature 'Govbox registration', type: :feature do
  scenario 'User registers for govbox' do
    visit '/sluzby/govbox'
    within('#registration') do
      click_on 'Mám záujem o GovBox'
    end

    fill_in 'Názov', with: 'Slovensko.Digital'
    fill_in 'IČO', with: '50 158 635'
    fill_in 'Adresa', with: 'Staré grunty 12, 841 04 Bratislava - mestská časť Karlova Ves'
    click_on 'Ďalej'

    fill_in 'Meno', with: 'Ján'
    fill_in 'Priezvisko', with: 'Hargaš'
    fill_in 'Trvalé bydlisko', with: 'Koprivnická 9/B, 841 04 Bratislava'
    click_on 'Ďalej'

    fill_in 'Email', with: 'jan.hargas@slovensko.digital'
    fill_in 'Telefónne číslo', with: '0903 919 123'
    fill_in 'Korešpondenčná adresa', with: 'Púpavová 31, 841 01 Bratislava'
    check 'Mám záujem si niektoré správy nechať zasielať aj klasickou poštou.'
    click_on 'Ďalej'

    fill_in 'Zvoľte si heslo', with: 'nejakeheslo'
    fill_in 'Heslo (znova)', with: 'nejakeheslo'

    stub_request(:post, ENV.fetch('GOVBOX_FORM_ENDPOINT')).
      with(body: {'cin' => '50 158 635', 'email' => 'jan.hargas@slovensko.digital', 'family_name' => 'Hargaš',
        'formatted_address' => 'Staré grunty 12, 841 04 Bratislava - mestská časť Karlova Ves',
        'given_name' => 'Ján', 'legal_subject_name' => 'Slovensko.Digital',
        'password' => 'nejakeheslo', 'password_confirmation' => 'nejakeheslo',
        'person_formatted_address' => 'Koprivnická 9/B, 841 04 Bratislava', 'phone' => '0903 919 123',
        'postal_address' => 'Púpavová 31, 841 01 Bratislava', 'snail_mail' => '1',
        'ga_user_id' => '', 'referral_code' => '',
      }).to_return(status: 201)
    click_on 'Dokončiť registráciu'

    expect(page).to have_content('Registrácia úspešná!')
  end

  scenario 'User cannot finish registers for govbox' do
    visit '/sluzby/govbox'
    within('#header') do
      click_on 'Mám záujem o GovBox'
    end

    fill_in 'Názov', with: 'Slovensko.Digital'
    fill_in 'IČO', with: '50 158 635'
    fill_in 'Adresa', with: 'Staré grunty 12, 841 04 Bratislava - mestská časť Karlova Ves'
    click_on 'Ďalej'

    fill_in 'Meno', with: 'Ján'
    fill_in 'Priezvisko', with: 'Hargaš'
    fill_in 'Trvalé bydlisko', with: 'Koprivnická 9/B, 841 04 Bratislava'
    click_on 'Ďalej'

    fill_in 'Email', with: 'jan.hargas@slovensko.digital'
    fill_in 'Telefónne číslo', with: '0903 919 123'
    fill_in 'Korešpondenčná adresa', with: 'Púpavová 31, 841 01 Bratislava'
    check 'Mám záujem si niektoré správy nechať zasielať aj klasickou poštou.'
    click_on 'Ďalej'

    fill_in 'Zvoľte si heslo', with: 'nejakeheslo'
    fill_in 'Heslo (znova)', with: 'nejakeheslo'

    stub_request(:post, ENV.fetch('GOVBOX_FORM_ENDPOINT')).to_return(status: [500, 'Internal Server Error'])

    click_on 'Dokončiť registráciu'

    expect(page).to have_content('momentálne nie je možné dokončiť registráciu')

    stub_request(:post, ENV.fetch('GOVBOX_FORM_ENDPOINT')).
      with(body: {'cin' => '50 158 635', 'email' => 'jan.hargas@slovensko.digital', 'family_name' => 'Hargaš',
        'formatted_address' => 'Staré grunty 12, 841 04 Bratislava - mestská časť Karlova Ves',
        'given_name' => 'Ján', 'legal_subject_name' => 'Slovensko.Digital',
        'password' => 'nejakeheslo', 'password_confirmation' => 'nejakeheslo',
        'person_formatted_address' => 'Koprivnická 9/B, 841 04 Bratislava', 'phone' => '0903 919 123',
        'postal_address' => 'Púpavová 31, 841 01 Bratislava', 'snail_mail' => '1',
        'ga_user_id' => '', 'referral_code' => ''
      }).to_return(status: 201)

    click_on 'Skúsiť dokončiť registráciu znova'

    expect(page).to have_content('Registrácia úspešná!')
  end

  scenario 'We track referral code' do
    visit '/sluzby/govbox?ref=sf'
    within('#registration') do
      click_on 'Mám záujem o GovBox'
    end

    fill_in 'Názov', with: 'Slovensko.Digital'
    fill_in 'IČO', with: '50 158 635'
    fill_in 'Adresa', with: 'Staré grunty 12, 841 04 Bratislava - mestská časť Karlova Ves'
    click_on 'Ďalej'

    fill_in 'Meno', with: 'Ján'
    fill_in 'Priezvisko', with: 'Hargaš'
    fill_in 'Trvalé bydlisko', with: 'Koprivnická 9/B, 841 04 Bratislava'
    click_on 'Ďalej'

    fill_in 'Email', with: 'jan.hargas@slovensko.digital'
    fill_in 'Telefónne číslo', with: '0903 919 123'
    fill_in 'Korešpondenčná adresa', with: 'Púpavová 31, 841 01 Bratislava'
    check 'Mám záujem si niektoré správy nechať zasielať aj klasickou poštou.'
    click_on 'Ďalej'

    fill_in 'Zvoľte si heslo', with: 'nejakeheslo'
    fill_in 'Heslo (znova)', with: 'nejakeheslo'

    stub_request(:post, ENV.fetch('GOVBOX_FORM_ENDPOINT')).to_return(status: [500, 'Internal Server Error'])

    click_on 'Dokončiť registráciu'

    stub_request(:post, ENV.fetch('GOVBOX_FORM_ENDPOINT')).
      with(body: {'cin' => '50 158 635', 'email' => 'jan.hargas@slovensko.digital', 'family_name' => 'Hargaš',
        'formatted_address' => 'Staré grunty 12, 841 04 Bratislava - mestská časť Karlova Ves',
        'given_name' => 'Ján', 'legal_subject_name' => 'Slovensko.Digital',
        'password' => 'nejakeheslo', 'password_confirmation' => 'nejakeheslo',
        'person_formatted_address' => 'Koprivnická 9/B, 841 04 Bratislava', 'phone' => '0903 919 123',
        'postal_address' => 'Púpavová 31, 841 01 Bratislava', 'snail_mail' => '1',
        'ga_user_id' => '', 'referral_code' => 'sf'
      }).to_return(status: 201)

    click_on 'Skúsiť dokončiť registráciu znova'

    expect(page).to have_content('Registrácia úspešná!')
  end
end
