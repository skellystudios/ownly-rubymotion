include SugarCube::CoreGraphics

class AppDelegate

  attr_reader :window

  @@placard_files = 
    [
#      {"placards/C10.png" => ""},
#      {"placards/C11.png" => ""},
      {"placards/C12.png" => "http://www.lyst.com/jewelry/marc-by-marc-jacobs-bolts-leather-bracelet-black-gold-2/"},
#      {"placards/C13.png" => ""},
      {"placards/C4.png"  => "http://www.forever21.com/Product/Product.aspx?BR=f21&Category=bottom_shorts&ProductID=2055171805&VariantID="},
      {"placards/C5.png"  => "https://blackmilkclothing.com/products/call-of-napoleon-leggings"},
      {"placards/C6.png"  => "http://www.tiffanybluenikeclub.com/popular-colorways-93421122-sex-swimsuit-2013-turquoise-flower-bikini-for-cheap-sale-p-2431.html?zenid=5485f94fdd814b0ae0b5dbeacde5bea9"},
      {"placards/C7.png"  => "http://www.watchismo.com/vestal-zr2-zr2002.aspx"},
      {"placards/C8.png"  => "http://www.ray-ban.com/usa/sunglasses/RB4132%20unisex%201-CLUBMASTER%20CATHY-Havana/805289364832"},
#      {"placards/C9.png"  => ""},
      {"placards/M11.png" => "http://www.converse.com/regular/chuck-taylor-fresh-colors/MP_154.html?dwvar_MP__154_color=deep%20ultramarine&dwvar_MP__154_size=030"},
      {"placards/M15.png" => "http://store.americanapparel.net/product/?productId=rsabnr"},
      {"placards/M17.png" => "http://www.ray-ban.com/uk/products/sun/icons/RB2140?var=901"},
      {"placards/M22.png" => "http://www.asos.com/River-Island/River-Island-Denim-Playsuit/Prod/pgeproduct.aspx?iid=2903426&SearchQuery=denim%20playsuit&sh=0&pge=0&pgesize=36&sort=-1&clr=Middenim"},
      {"placards/M23.png" => "http://www1.macys.com/shop/product/levis-jacket-classic-trucker-saddle-blue-wash?ID=874769&CategoryID=120&LinkType=PDPZ1"},
      {"placards/M29.png" => "http://uk.tommy.com/Alberta-Check-Shirt/1M87630106,en_GB,pd.html?cgid=103000#!color%3D305%26i%3D25%26sz%3D120%26size%3D12"},
      {"placards/M30.png" => "http://www.asos.com/Dune/Dune-Burst-Green-Metallic-Heeled-Court-Shoes/Prod/pgeproduct.aspx?iid=3437851&cid=4172&Rf900=1549&Rf-200=2&Rf947=4108&sh=0&pge=0&pgesize=200&sort=-1&clr=Green"},
      {"placards/M32.png" => "http://www.jaeger.co.uk/Leather%20Crossfront%20Biker/570015G,en_GB,pd.html?dwvar_570015G_color=00100&dwvar_570015G_size=6&start=8&cgid=women-jackets"},
      {"placards/M33.png" => "http://www.farfetch.com/shopping/women/dolce-gabbana-cable-knit-scarf-item-10471568.aspx"},
      {"placards/M35.png" => "http://store.americanapparel.net/product/?productId=rsads300"},
      {"placards/M36.png" => "http://www.lyst.com/clothing/jane-norman-stripe-halter-neck-dress-blackwhite/"},
      {"placards/M37.png" => "http://store.americanapparel.net/2001ha.html"},
      {"placards/M38.png" => "http://us.levi.com/product/index.jsp?productId=21933676&jsessionid=jDsjSmrf4B9pjcPtcmnH7GLJ7LpgCQTXxbwpZ52L9X4djBh9Qqvx%211770702839&&cp=3146842.3146845.3146860.11896263"},
      {"placards/M39.png" => "http://store.americanapparel.net/product/?productId=lcdheart"},
      {"placards/M42.png" => "http://store.americanapparel.net/product/?productId=5398"},
      {"placards/M43.png" => "http://store.americanapparel.net/product/?productId=rsa0325c"},
      {"placards/M44.png" => "http://www.topman.com/en/tmuk/product/clothing-140502/mens-hoodies-sweatshirts-2179526/pewter-marl-kangaroo-hoody-2414072?bi=1&ps=20"},
      {"placards/M45.png" => "http://www.topshop.com/webapp/wcs/stores/servlet/ProductDisplay?searchTerm=leopard+print+coat&storeId=12556&productId=12617312&urlRequestType=Base&categoryId=&langId=-1&productIdentifier=product&catalogId=33057"},
      {"placards/M47.png" => "http://www.hm.com/gb/product/07114"},
      {"placards/M49.png" => "http://www.hm.com/gb/product/08241"},
      {"placards/M51.png" => "http://www.missguidedus.com/catalog/product/view/id/99694/s/zaura-tartan-dungarees-mini-dress/"},
      {"placards/M53.png" => "http://www.urbanoutfitters.com/urban/catalog/productdetail.jsp?id=28530608&color=049&parentid=MORE%20IDEAS"},
      {"placards/M54.png" => "http://www.nastygal.com/sale-bottoms/highway-denim-shorts-white"},
      {"placards/M55.png" => "http://www.asos.com/ASOS/ASOS-Leopard-Cami-Print-Dress/Prod/pgeproduct.aspx?iid=3527243&SearchQuery=leopard&sh=0&pge=0&pgesize=204&sort=-1&clr=Leopard"},
#      {"placards/M56.png" => ""},
#      {"placards/M58.png" => ""},
      {"placards/M72.png" => "http://www.jimmychoo.com/en/women/shoes/pumps/ari/black-shiny-calf-pointy-toe-pumps-247arisnc.html?dwvar_247arisnc_color=Black&start=3&dwvar_247arisnc_size=35"},
      {"placards/M79.png" => "http://www.net-a-porter.com/product/383863"},
      {"placards/M80.png" => "http://shopbaobaoisseymiyake.com/bag/lucent-basic-tote?oid=1"},
      {"placards/M81.png" => "http://www.mrporter.com/product/361222"},
      {"placards/M90.png" => "http://www.tomford.com/#/en/eyewear/womens/sun?styleNumber=FT230&variantID=65F"},
      {"placards/M91.png" => "http://www.tomford.com/#/en/eyewear/womens/sun?styleNumber=FT230&variantID=65F"},
      {"placards/W10.png" => "http://store.frankiesbikinis.com/products/mistos-bottom"},
      {"placards/W1.jpg"  => "http://dope.com/matte-black-logo-beanie-2291"},
      {"placards/W2.png"  => "http://www.asos.com/Freya/Freya-Cha-Cha-Tie-Side-Bikini-Bottom/Prod/pgeproduct.aspx?iid=3154488&cid=10117&Rf-200=1&sh=0&pge=0&pgesize=36&sortu=-1&clr=Red"},
      {"placards/W3.png"  => "http://www.etsy.com/uk/listing/164523752/sterling-silver-wire-wrapped-necklace?ref=shop_home_active"},
      {"placards/W4.png"  => "http://store.americanapparel.net/product/8384.html"},
      {"placards/W5.png"  => "http://store.frankiesbikinis.com/collections/all-products/products/luna"},
      {"placards/W6.png"  => "http://www.escentual.com/michael-kors/michaelkorssexy007/?gclid=CI_kuuW1pLsCFSTItAodDAoAxQ"},
      {"placards/W11.png"  => "http://store.frankiesbikinis.com/collections/all-products/products/kaia-top"}
#      {"placards/W8.png"  => ""}
    ].shuffle

  def self.PLACARD_FILES
    @@placard_files
  end

  def self.saved_placards
    @@saved_placards
  end

  def self.saved_placards=(placards)
    @@saved_placards = placards
  end

  def application(application, didFinishLaunchingWithOptions:launchOptions)

    @@saved_placards = []

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    root = RootViewController.alloc.init
    nav_controller = UINavigationController.alloc.initWithRootViewController(root)
    
    image = UIImage.imageNamed('navbar.png')
    nav_controller.navigationBar.setBackgroundImage(image, forBarMetrics:UIBarMetricsDefault)

    @window.rootViewController = nav_controller
    @window.makeKeyAndVisible
    true
  end
end
