class StaticController < ContentController
  def terms
    @page.title = 'Podmienky používania &middot; Ekosystém.Slovensko.Digital'.html_safe
    @page.og.description = ' Licenciu sme nastavili tak, aby boli podmienky používania úplne minimálne a mohli s dátami v princípe robiť čo chcete. Detailné podmienky v právničtine odporúča prečítať 10 z 10 právnikov.'
  end
end
