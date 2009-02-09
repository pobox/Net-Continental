use strict;
use warnings;

package Net::Continental;
use Carp ();
use Scalar::Util qw(blessed);

our %Continent = (
  N => 'North America',
  S => 'South America',
  E => 'Europe',
  A => 'Asia',
  F => 'Africa',
  O => 'Oceania',
  Q => 'Antarctica',
);

# qw(in_nerd continent description)

my %zone = (
  ac => [ 0 => F => q{Ascension Island} ],
  ax => [ 0 => E => q(Aland Islands) ],
  bl => [ 0 => N => q(Saint Barthelemy) ],
  cd => [ 0 => F => q{Congo, Democratic Republic of the} ],
  eu => [ 0 => E => q{European Union} ],
  im => [ 0 => E => q{Isle of Man} ],
  je => [ 0 => E => q{Jersey} ],
  me => [ 0 => E => q(Montenegro) ],
  mf => [ 0 => N => q{Saint Martin (French part)} ],
  rs => [ 0 => E => q(Serbia) ],
  tl => [ 0 => A => q{Timor-Leste} ],
        
  ae => [ 1 => A => q{United Arab Emirates} ],
  af => [ 1 => A => q{Afghanistan} ],
  az => [ 1 => A => q{Azerbaijan} ],
  bd => [ 1 => A => q{Bangladesh} ],
  bh => [ 1 => A => q{Bahrain} ],
  bt => [ 1 => A => q{Bhutan} ],
  cn => [ 1 => A => q{China} ],
        
  # classification of Georgia in Europe or Asia is touchy
  ge => [ 1 => A => q{Georgia} ],
        
  hk => [ 1 => A => q{Hong Kong} ],
  il => [ 1 => A => q{Israel} ],
  in => [ 1 => A => q{India} ],
  iq => [ 1 => A => q{Iraq} ],
  ir => [ 1 => A => q{Iran (Islamic Republic of)} ],
  jo => [ 1 => A => q{Jordan} ],
  jp => [ 1 => A => q{Japan} ],
  kg => [ 1 => A => q{Kyrgyzstan} ],
  kh => [ 1 => A => q{Cambodia} ],
  kp => [ 1 => A => q{Korea, Democratic People's Republic} ],
  kr => [ 1 => A => q{Korea, Republic of} ],
  kw => [ 1 => A => q{Kuwait} ],
  kz => [ 1 => A => q{Kazakhstan} ],
  la => [ 1 => A => q{Lao People's Democratic Republic} ],
  lb => [ 1 => A => q{Lebanon} ],
  lk => [ 1 => A => q{Sri Lanka} ],
  mm => [ 1 => A => q{Myanmar} ],
  mn => [ 1 => A => q{Mongolia} ],
  mo => [ 1 => A => q{Macau} ],
  mv => [ 1 => A => q{Maldives} ],
  my => [ 1 => A => q{Malaysia} ],
  np => [ 1 => A => q{Nepal} ],
  om => [ 1 => A => q{Oman} ],
  ph => [ 1 => A => q{Philippines} ],
  pk => [ 1 => A => q{Pakistan} ],
  ps => [ 1 => A => q{Palestinian Territories} ],
  qa => [ 1 => A => q{Qatar} ],
  ru => [ 1 => A => q{Russian Federation} ],
  sa => [ 1 => A => q{Saudi Arabia} ],
  sg => [ 1 => A => q{Singapore} ],
  su => [ 1 => A => q{Soviet Union} ],
  sy => [ 1 => A => q{Syrian Arab Republic} ],
  th => [ 1 => A => q{Thailand} ],
  tj => [ 1 => A => q{Tajikistan} ],
  tm => [ 1 => A => q{Turkmenistan} ],
  tp => [ 1 => A => q{East Timor} ],
  tr => [ 1 => A => q{Turkey} ],
  tw => [ 1 => A => q{Taiwan} ],
  uz => [ 1 => A => q{Uzbekistan} ],
  vn => [ 1 => A => q{Vietnam} ],
  ye => [ 1 => A => q{Yemen} ],
  ad => [ 1 => E => q{Andorra} ],
  al => [ 1 => E => q{Albania} ],
  am => [ 1 => E => q{Armenia} ],
  at => [ 1 => E => q{Austria} ],
  ba => [ 1 => E => q{Bosnia and Herzegovina} ],
  be => [ 1 => E => q{Belgium} ],
  bg => [ 1 => E => q{Bulgaria} ],
  by => [ 1 => E => q{Belarus} ],
  ch => [ 1 => E => q{Switzerland} ],
  cy => [ 1 => E => q{Cyprus} ],
  cz => [ 1 => E => q{Czech Republic} ],
  de => [ 1 => E => q{Germany} ],
  dk => [ 1 => E => q{Denmark} ],
  ee => [ 1 => E => q{Estonia} ],
  es => [ 1 => E => q{Spain} ],
  fi => [ 1 => E => q{Finland} ],
  fo => [ 1 => E => q{Faroe Islands} ],
  fr => [ 1 => E => q{France} ],
  fx => [ 1 => E => q{France, Metropolitan} ],
  gb => [ 1 => E => q{United Kingdom} ],
  gg => [ 1 => E => q{Guernsey} ],
  gi => [ 1 => E => q{Gibraltar} ],
  gr => [ 1 => E => q{Greece} ],
  hr => [ 1 => E => q{Croatia/Hrvatska} ],
  hu => [ 1 => E => q{Hungary} ],
  ie => [ 1 => E => q{Ireland} ],
  is => [ 1 => E => q{Iceland} ],
  it => [ 1 => E => q{Italy} ],
  li => [ 1 => E => q{Liechtenstein} ],
  lt => [ 1 => E => q{Lithuania} ],
  lu => [ 1 => E => q{Luxembourg} ],
  lv => [ 1 => E => q{Latvia} ],
  mc => [ 1 => E => q{Monaco} ],
  md => [ 1 => E => q{Moldova, Republic of} ],
  mk => [ 1 => E => q{Macedonia, Former Yugoslav Republic} ],
  mt => [ 1 => E => q{Malta} ],
  nl => [ 1 => E => q{Netherlands} ],
  no => [ 1 => E => q{Norway} ],
  pl => [ 1 => E => q{Poland} ],
  pt => [ 1 => E => q{Portugal} ],
  ro => [ 1 => E => q{Romania} ],
  se => [ 1 => E => q{Sweden} ],
  si => [ 1 => E => q{Slovenia} ],
  sj => [ 1 => E => q{Svalbard and Jan Mayen Islands} ],
  sk => [ 1 => E => q{Slovak Republic} ],
  sm => [ 1 => E => q{San Marino} ],
  ua => [ 1 => E => q{Ukraine} ],
  uk => [ 1 => E => q{United Kingdom} ],
  va => [ 1 => E => q{Holy See (City Vatican State)} ],
  yu => [ 1 => E => q{Yugoslavia} ],
  ao => [ 1 => F => q{Angola} ],
  bf => [ 1 => F => q{Burkina Faso} ],
  bi => [ 1 => F => q{Burundi} ],
  bj => [ 1 => F => q{Benin} ],
  bw => [ 1 => F => q{Botswana} ],
  cf => [ 1 => F => q{Central African Republic} ],
  cg => [ 1 => F => q{Congo, Republic of} ],
  ci => [ 1 => F => q{Cote d'Ivoire} ],
  cm => [ 1 => F => q{Cameroon} ],
  cv => [ 1 => F => q{Cap Verde} ],
  dj => [ 1 => F => q{Djibouti} ],
  dz => [ 1 => F => q{Algeria} ],
  eg => [ 1 => F => q{Egypt} ],
  eh => [ 1 => F => q{Western Sahara} ],
  er => [ 1 => F => q{Eritrea} ],
  et => [ 1 => F => q{Ethiopia} ],
  ga => [ 1 => F => q{Gabon} ],
  gf => [ 1 => F => q{French Guiana} ],
  gh => [ 1 => F => q{Ghana} ],
  gm => [ 1 => F => q{Gambia} ],
  gn => [ 1 => F => q{Guinea} ],
  gq => [ 1 => F => q{Equatorial Guinea} ],
  gw => [ 1 => F => q{Guinea-Bissau} ],
  gy => [ 1 => F => q{Guyana} ],
  ke => [ 1 => F => q{Kenya} ],
  km => [ 1 => F => q{Comoros} ],
  lr => [ 1 => F => q{Liberia} ],
  ls => [ 1 => F => q{Lesotho} ],
  ly => [ 1 => F => q{Libyan Arab Jamahiriya} ],
  ma => [ 1 => F => q{Morocco} ],
  mg => [ 1 => F => q{Madagascar} ],
  ml => [ 1 => F => q{Mali} ],
  mr => [ 1 => F => q{Mauritania} ],
  mu => [ 1 => F => q{Mauritius} ],
  mw => [ 1 => F => q{Malawi} ],
  mz => [ 1 => F => q{Mozambique} ],
  na => [ 1 => F => q{Namibia} ],
  ne => [ 1 => F => q{Niger} ],
  ng => [ 1 => F => q{Nigeria} ],
  re => [ 1 => F => q{Reunion Island} ],
  rw => [ 1 => F => q{Rwanda} ],
  sc => [ 1 => F => q{Seychelles} ],
  sd => [ 1 => F => q{Sudan} ],
  sh => [ 1 => F => q{St. Helena} ],
  sl => [ 1 => F => q{Sierra Leone} ],
  sn => [ 1 => F => q{Senegal} ],
  so => [ 1 => F => q{Somalia} ],
  st => [ 1 => F => q{Sao Tome and Principe} ],
  sz => [ 1 => F => q{Swaziland} ],
  td => [ 1 => F => q{Chad} ],
  tg => [ 1 => F => q{Togo} ],
  tn => [ 1 => F => q{Tunisia} ],
  to => [ 1 => F => q{Tonga} ],
  tz => [ 1 => F => q{Tanzania} ],
  ug => [ 1 => F => q{Uganda} ],
  yt => [ 1 => F => q{Mayotte} ],
  za => [ 1 => F => q{South Africa} ],
  zm => [ 1 => F => q{Zambia} ],
  zr => [ 1 => F => q{Zaire} ],
  zw => [ 1 => F => q{Zimbabwe} ],
  ag => [ 1 => N => q{Antigua and Barbuda} ],
  ai => [ 1 => N => q{Anguilla} ],
  an => [ 1 => N => q{Netherlands Antilles} ],
  aw => [ 1 => N => q{Aruba} ],
  bb => [ 1 => N => q{Barbados} ],
  bm => [ 1 => N => q{Bermuda} ],
  bo => [ 1 => N => q{Bolivia} ],
  bs => [ 1 => N => q{Bahamas} ],
  bz => [ 1 => N => q{Belize} ],
  ca => [ 1 => N => q{Canada} ],
  co => [ 1 => N => q{Colombia} ],
  cr => [ 1 => N => q{Costa Rica} ],
  cu => [ 1 => N => q{Cuba} ],
  do => [ 1 => N => q{Dominican Republic} ],
  ec => [ 1 => N => q{Ecuador} ],
  gl => [ 1 => N => q{Greenland} ],
  gt => [ 1 => N => q{Guatemala} ],
  hn => [ 1 => N => q{Honduras} ],
  ht => [ 1 => N => q{Haiti} ],
  jm => [ 1 => N => q{Jamaica} ],
  kn => [ 1 => N => q{Saint Kitts and Nevis} ],
  lc => [ 1 => N => q{Saint Lucia} ],
  mq => [ 1 => N => q{Martinique} ],
  ms => [ 1 => N => q{Montserrat} ],
  mx => [ 1 => N => q{Mexico} ],
  ni => [ 1 => N => q{Nicaragua} ],
  pa => [ 1 => N => q{Panama} ],
  pm => [ 1 => N => q{St. Pierre and Miquelon} ],
  pr => [ 1 => N => q{Puerto Rico} ],
  sv => [ 1 => N => q{El Salvador} ],
  tc => [ 1 => N => q{Turks and Caicos Islands} ],
  tt => [ 1 => N => q{Trinidad and Tobago} ],
  us => [ 1 => N => q{United States} ],
  vc => [ 1 => N => q{Saint Vincent and the Grenadines} ],
  vg => [ 1 => N => q{Virgin Islands (British)} ],
  vi => [ 1 => N => q{Virgin Islands (USA)} ],
  as => [ 1 => O => q{American Samoa} ],
  au => [ 1 => O => q{Australia} ],
  bn => [ 1 => O => q{Brunei Darussalam} ],
  cc => [ 1 => O => q{Cocos (Keeling) Islands} ],
  ck => [ 1 => O => q{Cook Islands} ],
  cx => [ 1 => O => q{Christmas Island} ],
  dm => [ 1 => O => q{Dominica} ],
  fj => [ 1 => O => q{Fiji} ],
  fm => [ 1 => O => q{Micronesia, Federated States of} ],
  gu => [ 1 => O => q{Guam} ],
  id => [ 1 => O => q{Indonesia} ],
  io => [ 1 => O => q{British Indian Ocean Territory} ],
  ki => [ 1 => O => q{Kiribati} ],
  ky => [ 1 => O => q{Cayman Islands} ],
  mh => [ 1 => O => q{Marshall Islands} ],
  mp => [ 1 => O => q{Northern Mariana Islands} ],
  nc => [ 1 => O => q{New Caledonia} ],
  nf => [ 1 => O => q{Norfolk Island} ],
  nr => [ 1 => O => q{Nauru} ],
  nu => [ 1 => O => q{Niue} ],
  nz => [ 1 => O => q{New Zealand} ],
  pf => [ 1 => O => q{French Polynesia} ],
  pg => [ 1 => O => q{Papua New Guinea} ],
  pn => [ 1 => O => q{Pitcairn Island} ],
  pw => [ 1 => O => q{Palau} ],
  sb => [ 1 => O => q{Solomon Islands} ],
  tk => [ 1 => O => q{Tokelau} ],
  tv => [ 1 => O => q{Tuvalu} ],
  um => [ 1 => O => q{US Minor Outlying Islands} ],
  vu => [ 1 => O => q{Vanuatu} ],
  wf => [ 1 => O => q{Wallis and Futuna Islands} ],
  ws => [ 1 => O => q{Western Samoa} ],
  aq => [ 1 => Q => q{Antartica} ],
  bv => [ 1 => Q => q{Bouvet Island} ],
  gs => [ 1 => Q => q{South Georgia and the South Sandwich Islands} ],
  hm => [ 1 => Q => q{Heard and McDonald Islands} ],
  tf => [ 1 => Q => q{French Southern Territories} ],
  ar => [ 1 => S => q{Argentina} ],
  br => [ 1 => S => q{Brazil} ],
  cl => [ 1 => S => q{Chile} ],
  fk => [ 1 => S => q{Falkland Islands (Malvina)} ],
  gd => [ 1 => S => q{Grenada} ],
  gp => [ 1 => S => q{Guadeloupe} ],
  pe => [ 1 => S => q{Peru} ],
  py => [ 1 => S => q{Paraguay} ],
  sr => [ 1 => S => q{Suriname} ],
  uy => [ 1 => S => q{Uruguay} ],
  ve => [ 1 => S => q{Venezuela} ],
);

sub zone {
  my ($self, $code) = @_;
  Carp::croak("unknown code $code ") unless exists $zone{$code};

  $zone{ $code } = Net::Continental::Zone->_new([ $code, @{ $zone{ $code } } ])
    unless blessed $zone{ $code };

  return $zone{ $code };
}

1;
