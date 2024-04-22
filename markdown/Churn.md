Customer Churn Prediction
================
134780 Trevor Okinda
April 2024

- [Student Details](#student-details)
- [Setup Chunk](#setup-chunk)

# Student Details

|                       |                                 |
|-----------------------|---------------------------------|
| **Student ID Number** | 134780                          |
| **Student Name**      | Trevor Okinda                   |
| **BBIT 4.2 Group**    | C                               |
| **Project Name**      | Customer Churn Prediction Model |

# Setup Chunk

**Note:** the following KnitR options have been set as the global
defaults: <BR>
`knitr::opts_chunk$set(echo = TRUE, warning = FALSE, eval = TRUE, collapse = FALSE, tidy = TRUE)`.

More KnitR options are documented here
<https://bookdown.org/yihui/rmarkdown-cookbook/chunk-options.html> and
here <https://yihui.org/knitr/options/>.

``` r
# Load dataset
churn_data <- read.csv("Telco_customer_churn.csv", colClasses = c(
  CustomerID = "character",
  Count = "factor",
  Country = "factor",
  State = "factor",
  City = "factor",
  Zip_Code = "factor",
  Lat_Long = "character",
  Latitude = "numeric",
  Longitude = "numeric",
  Gender = "factor",
  Senior_Citizen = "factor",
  Partner = "factor",
  Dependents = "factor",
  Tenure_Months = "numeric",
  Phone_Service = "factor",
  Multiple_Lines = "factor",
  Internet_Service = "factor",
  Online_Security = "factor",
  Online_Backup = "factor",
  Device_Protection = "factor",
  Tech_Support = "factor",
  Streaming_TV = "factor",
  Streaming_Movies = "factor",
  Contract = "factor",
  Paperless_Billing = "factor",
  Payment_Method = "factor",
  Monthly_Charges = "numeric",
  Total_Charges = "numeric",
  Churn_Label = "factor",
  Churn_Value = "numeric",
  Churn_Score = "numeric",
  CLTV = "numeric",
  Churn_Reason = "factor"
))

# Display the structure of the dataset
str(churn_data)
```

    ## 'data.frame':    7043 obs. of  33 variables:
    ##  $ CustomerID       : chr  "3668-QPYBK" "9237-HQITU" "9305-CDSKC" "7892-POOKP" ...
    ##  $ Count            : Factor w/ 1 level "1": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Country          : Factor w/ 1 level "United States": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ State            : Factor w/ 1 level "California": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ City             : Factor w/ 1129 levels "Acampo","Acton",..: 563 563 563 563 563 563 563 563 563 563 ...
    ##  $ Zip_Code         : Factor w/ 1652 levels "90001","90002",..: 3 5 6 9 14 19 21 23 27 28 ...
    ##  $ Lat_Long         : chr  "33.964131, -118.272783" "34.059281, -118.30742" "34.048013, -118.293953" "34.062125, -118.315709" ...
    ##  $ Latitude         : num  34 34.1 34 34.1 34 ...
    ##  $ Longitude        : num  -118 -118 -118 -118 -118 ...
    ##  $ Gender           : Factor w/ 2 levels "Female","Male": 2 1 1 1 2 1 2 2 2 2 ...
    ##  $ Senior_Citizen   : Factor w/ 2 levels "No","Yes": 1 1 1 1 1 1 2 1 1 1 ...
    ##  $ Partner          : Factor w/ 2 levels "No","Yes": 1 1 1 2 1 2 1 1 2 2 ...
    ##  $ Dependents       : Factor w/ 2 levels "No","Yes": 1 2 2 2 2 1 1 1 2 1 ...
    ##  $ Tenure_Months    : num  2 2 8 28 49 10 1 1 47 1 ...
    ##  $ Phone_Service    : Factor w/ 2 levels "No","Yes": 2 2 2 2 2 2 1 2 2 1 ...
    ##  $ Multiple_Lines   : Factor w/ 3 levels "No","No phone service",..: 1 1 3 3 3 1 2 1 3 2 ...
    ##  $ Internet_Service : Factor w/ 3 levels "DSL","Fiber optic",..: 1 2 2 2 2 1 1 3 2 1 ...
    ##  $ Online_Security  : Factor w/ 3 levels "No","No internet service",..: 3 1 1 1 1 1 1 2 1 1 ...
    ##  $ Online_Backup    : Factor w/ 3 levels "No","No internet service",..: 3 1 1 1 3 1 1 2 3 3 ...
    ##  $ Device_Protection: Factor w/ 3 levels "No","No internet service",..: 1 1 3 3 3 3 3 2 1 1 ...
    ##  $ Tech_Support     : Factor w/ 3 levels "No","No internet service",..: 1 1 1 3 1 3 1 2 1 1 ...
    ##  $ Streaming_TV     : Factor w/ 3 levels "No","No internet service",..: 1 1 3 3 3 1 1 2 3 1 ...
    ##  $ Streaming_Movies : Factor w/ 3 levels "No","No internet service",..: 1 1 3 3 3 1 3 2 3 1 ...
    ##  $ Contract         : Factor w/ 3 levels "Month-to-month",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Paperless_Billing: Factor w/ 2 levels "No","Yes": 2 2 2 2 2 1 2 1 2 1 ...
    ##  $ Payment_Method   : Factor w/ 4 levels "Bank transfer (automatic)",..: 4 3 3 3 1 2 3 4 3 3 ...
    ##  $ Monthly_Charges  : num  53.9 70.7 99.7 104.8 103.7 ...
    ##  $ Total_Charges    : num  108 152 820 3046 5036 ...
    ##  $ Churn_Label      : Factor w/ 2 levels "No","Yes": 2 2 2 2 2 2 2 2 2 2 ...
    ##  $ Churn_Value      : num  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Churn_Score      : num  86 67 86 84 89 78 100 92 77 97 ...
    ##  $ CLTV             : num  3239 2701 5372 5003 5340 ...
    ##  $ Churn_Reason     : Factor w/ 21 levels "","Attitude of service provider",..: 5 15 15 15 4 6 7 5 4 4 ...

``` r
# View the first few rows of the dataset
head(churn_data)
```

    ##   CustomerID Count       Country      State        City Zip_Code
    ## 1 3668-QPYBK     1 United States California Los Angeles    90003
    ## 2 9237-HQITU     1 United States California Los Angeles    90005
    ## 3 9305-CDSKC     1 United States California Los Angeles    90006
    ## 4 7892-POOKP     1 United States California Los Angeles    90010
    ## 5 0280-XJGEX     1 United States California Los Angeles    90015
    ## 6 4190-MFLUW     1 United States California Los Angeles    90020
    ##                 Lat_Long Latitude Longitude Gender Senior_Citizen Partner
    ## 1 33.964131, -118.272783 33.96413 -118.2728   Male             No      No
    ## 2  34.059281, -118.30742 34.05928 -118.3074 Female             No      No
    ## 3 34.048013, -118.293953 34.04801 -118.2940 Female             No      No
    ## 4 34.062125, -118.315709 34.06213 -118.3157 Female             No     Yes
    ## 5 34.039224, -118.266293 34.03922 -118.2663   Male             No      No
    ## 6 34.066367, -118.309868 34.06637 -118.3099 Female             No     Yes
    ##   Dependents Tenure_Months Phone_Service Multiple_Lines Internet_Service
    ## 1         No             2           Yes             No              DSL
    ## 2        Yes             2           Yes             No      Fiber optic
    ## 3        Yes             8           Yes            Yes      Fiber optic
    ## 4        Yes            28           Yes            Yes      Fiber optic
    ## 5        Yes            49           Yes            Yes      Fiber optic
    ## 6         No            10           Yes             No              DSL
    ##   Online_Security Online_Backup Device_Protection Tech_Support Streaming_TV
    ## 1             Yes           Yes                No           No           No
    ## 2              No            No                No           No           No
    ## 3              No            No               Yes           No          Yes
    ## 4              No            No               Yes          Yes          Yes
    ## 5              No           Yes               Yes           No          Yes
    ## 6              No            No               Yes          Yes           No
    ##   Streaming_Movies       Contract Paperless_Billing            Payment_Method
    ## 1               No Month-to-month               Yes              Mailed check
    ## 2               No Month-to-month               Yes          Electronic check
    ## 3              Yes Month-to-month               Yes          Electronic check
    ## 4              Yes Month-to-month               Yes          Electronic check
    ## 5              Yes Month-to-month               Yes Bank transfer (automatic)
    ## 6               No Month-to-month                No   Credit card (automatic)
    ##   Monthly_Charges Total_Charges Churn_Label Churn_Value Churn_Score CLTV
    ## 1           53.85        108.15         Yes           1          86 3239
    ## 2           70.70        151.65         Yes           1          67 2701
    ## 3           99.65        820.50         Yes           1          86 5372
    ## 4          104.80       3046.05         Yes           1          84 5003
    ## 5          103.70       5036.30         Yes           1          89 5340
    ## 6           55.20        528.35         Yes           1          78 5925
    ##                                Churn_Reason
    ## 1              Competitor made better offer
    ## 2                                     Moved
    ## 3                                     Moved
    ## 4                                     Moved
    ## 5             Competitor had better devices
    ## 6 Competitor offered higher download speeds

``` r
View(churn_data)
```

``` r
#Measures of Frequency
# Load dataset (assuming it's already loaded as churn_data)

# Define categorical variables
categorical_vars <- c("Count", "Country", "State", "City", "Zip_Code", 
                      "Gender", "Senior_Citizen", "Partner", "Dependents",
                      "Phone_Service", "Multiple_Lines", "Internet_Service",
                      "Online_Security", "Online_Backup", "Device_Protection",
                      "Tech_Support", "Streaming_TV", "Streaming_Movies",
                      "Contract", "Paperless_Billing", "Payment_Method",
                      "Churn_Label", "Churn_Reason")

# Generate measures of frequency for each categorical variable
for (var in categorical_vars) {
  cat(paste("Frequency table for variable:", var, "\n"))
  print(table(churn_data[[var]]))
  cat("\n")
}
```

    ## Frequency table for variable: Count 
    ## 
    ##    1 
    ## 7043 
    ## 
    ## Frequency table for variable: Country 
    ## 
    ## United States 
    ##          7043 
    ## 
    ## Frequency table for variable: State 
    ## 
    ## California 
    ##       7043 
    ## 
    ## Frequency table for variable: City 
    ## 
    ##                 Acampo                  Acton               Adelanto 
    ##                      4                      4                      5 
    ##                   Adin           Agoura Hills                Aguanga 
    ##                      4                      5                      4 
    ##               Ahwahnee                Alameda                  Alamo 
    ##                      4                      8                      4 
    ##                 Albany                 Albion             Alderpoint 
    ##                      4                      4                      4 
    ##               Alhambra            Aliso Viejo              Alleghany 
    ##                     10                      4                      4 
    ##                Alpaugh                 Alpine                   Alta 
    ##                      4                      5                      4 
    ##               Altadena                Alturas                 Alviso 
    ##                      5                      4                      4 
    ##            Amador City                  Amboy                Anaheim 
    ##                      4                      5                     28 
    ##               Anderson            Angels Camp           Angelus Oaks 
    ##                      4                      4                      5 
    ##                 Angwin              Annapolis               Antelope 
    ##                      4                      4                      4 
    ##                Antioch                   Anza           Apple Valley 
    ##                      4                      4                     10 
    ##              Applegate                  Aptos               Arbuckle 
    ##                      4                      4                      4 
    ##                Arcadia                 Arcata                 Armona 
    ##                     10                      4                      4 
    ##                 Arnold                 Aromas          Arroyo Grande 
    ##                      4                      4                      4 
    ##                Artesia                  Arvin             Atascadero 
    ##                      5                      4                      4 
    ##               Atherton                Atwater                Auberry 
    ##                      4                      4                      4 
    ##                 Auburn                 Avalon                 Avenal 
    ##                      8                      5                      4 
    ##                  Avery            Avila Beach                  Azusa 
    ##                      4                      4                      5 
    ##                 Badger                  Baker            Bakersfield 
    ##                      4                      4                     40 
    ##           Baldwin Park                Ballico                 Bangor 
    ##                      5                      4                      4 
    ##                Banning                Barstow              Bass Lake 
    ##                      5                      4                      4 
    ##                Bayside              Beale Afb               Beaumont 
    ##                      4                      4                      5 
    ##                   Bell            Bella Vista             Bellflower 
    ##                      5                      4                      5 
    ##                Belmont      Belvedere Tiburon             Ben Lomond 
    ##                      4                      4                      4 
    ##                Benicia                 Benton               Berkeley 
    ##                      4                      4                     32 
    ##            Berry Creek          Bethel Island          Beverly Hills 
    ##                      4                      4                     15 
    ##                 Bieber                Big Bar          Big Bear City 
    ##                      4                      4                      4 
    ##          Big Bear Lake               Big Bend              Big Creek 
    ##                      4                      4                      4 
    ##           Big Oak Flat               Big Pine                Big Sur 
    ##                      4                      4                      4 
    ##                  Biggs                  Biola          Birds Landing 
    ##                      4                      4                      4 
    ##                 Bishop     Blairsden Graeagle             Blocksburg 
    ##                      4                      4                      4 
    ##            Bloomington              Blue Lake                 Blythe 
    ##                      4                      4                      5 
    ##                 Bodega             Bodega Bay                Bodfish 
    ##                      4                      4                      4 
    ##                Bolinas                 Bonita                Bonsall 
    ##                      4                      5                      5 
    ##              Boonville                  Boron        Borrego Springs 
    ##                      4                      4                      5 
    ##          Boulder Creek              Boulevard                Bradley 
    ##                      4                      5                      4 
    ##              Branscomb                Brawley                   Brea 
    ##                      4                      5                      8 
    ##              Brentwood             Bridgeport            Bridgeville 
    ##                      4                      4                      4 
    ##               Brisbane              Brookdale                 Brooks 
    ##                      4                      4                      4 
    ##          Browns Valley            Brownsville               Buellton 
    ##                      4                      4                      4 
    ##             Buena Park                Burbank             Burlingame 
    ##                     10                     25                      4 
    ##                 Burney            Burnt Ranch                 Burson 
    ##                      4                      4                      4 
    ##             Butte City           Buttonwillow                  Byron 
    ##                      4                      4                      4 
    ##                Cabazon              Calabasas               Calexico 
    ##                      5                      5                      5 
    ##               Caliente        California City California Hot Springs 
    ##                      4                      4                      4 
    ##               Calimesa             Calipatria              Calistoga 
    ##                      4                      5                      4 
    ##               Callahan                Calpine              Camarillo 
    ##                      4                      4                      8 
    ##                Cambria                 Camino            Camp Nelson 
    ##                      4                      4                      4 
    ##               Campbell                  Campo             Campo Seco 
    ##                      4                      5                      4 
    ##           Camptonville                  Canby            Canoga Park 
    ##                      4                      4                     10 
    ##           Cantua Creek         Canyon Country             Canyon Dam 
    ##                      4                      5                      4 
    ##                  Capay       Capistrano Beach               Capitola 
    ##                      4                      4                      4 
    ##     Cardiff By The Sea               Carlotta               Carlsbad 
    ##                      5                      4                     10 
    ##                 Carmel      Carmel By The Sea          Carmel Valley 
    ##                      4                      4                      4 
    ##             Carmichael          Carnelian Bay            Carpinteria 
    ##                      4                      4                      4 
    ##                 Carson              Caruthers               Casmalia 
    ##                     10                      4                      4 
    ##                 Caspar                 Cassel                Castaic 
    ##                      4                      4                      5 
    ##               Castella          Castro Valley            Castroville 
    ##                      4                      8                      4 
    ##         Cathedral City         Catheys Valley                Cayucos 
    ##                      5                      4                      4 
    ##               Cazadero             Cedar Glen             Cedarville 
    ##                      4                      4                      4 
    ##                  Ceres               Cerritos              Challenge 
    ##                      4                      5                      4 
    ##             Chatsworth                Chester                  Chico 
    ##                      5                      4                     12 
    ##               Chilcoot                  Chino            Chino Hills 
    ##                      4                      5                      5 
    ##             Chowchilla                Chualar            Chula Vista 
    ##                      4                      4                     25 
    ##         Citrus Heights              Claremont             Clarksburg 
    ##                      8                      5                      4 
    ##                Clayton              Clearlake         Clearlake Oaks 
    ##                      4                      4                      4 
    ##               Clements                   Clio          Clipper Mills 
    ##                      4                      4                      4 
    ##             Cloverdale                 Clovis              Coachella 
    ##                      4                      8                      5 
    ##               Coalinga             Coarsegold                   Cobb 
    ##                      4                      4                      4 
    ##              Coleville                 Colfax                 Colton 
    ##                      4                      4                      4 
    ##               Columbia                 Colusa               Comptche 
    ##                      4                      4                      4 
    ##                Compton                Concord                   Cool 
    ##                     15                     16                      4 
    ##           Copperopolis               Corcoran                Corning 
    ##                      4                      4                      4 
    ##                 Corona         Corona Del Mar               Coronado 
    ##                     20                      4                      5 
    ##           Corte Madera             Costa Mesa                 Cotati 
    ##                      4                      8                      4 
    ##             Cottonwood           Coulterville              Courtland 
    ##                      4                      4                      4 
    ##                 Covelo                 Covina          Crescent City 
    ##                      4                     15                      4 
    ##         Crescent Mills                Cressey              Crestline 
    ##                      4                      4                      4 
    ##                Creston               Crockett          Crows Landing 
    ##                      4                      4                      4 
    ##            Culver City              Cupertino                 Cutler 
    ##                     10                      4                      4 
    ##                Cypress                Daggett              Daly City 
    ##                      5                      4                      8 
    ##             Dana Point               Danville                 Darwin 
    ##                      4                      8                      4 
    ##              Davenport                  Davis            Davis Creek 
    ##                      4                      8                      4 
    ##           Death Valley              Deer Park                Del Mar 
    ##                      4                      4                      5 
    ##                Del Rey                 Delano                  Delhi 
    ##                      4                      4                      4 
    ##                 Denair               Descanso          Desert Center 
    ##                      4                      5                      5 
    ##     Desert Hot Springs            Diamond Bar        Diamond Springs 
    ##                     10                      5                      4 
    ##           Dillon Beach                 Dinuba                  Dixon 
    ##                      4                      4                      4 
    ##                Dobbins                 Dorris              Dos Palos 
    ##                      4                      4                      4 
    ##               Dos Rios           Douglas City                 Downey 
    ##                      4                      4                     15 
    ##            Downieville                  Doyle                 Duarte 
    ##                      4                      4                      5 
    ##                 Dublin                  Ducor                Dulzura 
    ##                      4                      4                      5 
    ##          Duncans Mills                 Dunlap               Dunnigan 
    ##                      4                      4                      4 
    ##               Dunsmuir                 Durham             Dutch Flat 
    ##                      4                      4                      4 
    ##             Eagleville              Earlimart                   Earp 
    ##                      4                      4                      5 
    ##              Echo Lake                Edwards               El Cajon 
    ##                      4                      4                     15 
    ##              El Centro             El Cerrito              El Dorado 
    ##                      5                      4                      4 
    ##        El Dorado Hills               El Monte                El Nido 
    ##                      4                     10                      4 
    ##              El Portal             El Segundo            El Sobrante 
    ##                      4                      5                      4 
    ##               Eldridge                    Elk              Elk Creek 
    ##                      4                      4                      4 
    ##              Elk Grove                 Elmira                Elverta 
    ##                      8                      4                      4 
    ##             Emeryville           Emigrant Gap              Encinitas 
    ##                      4                      4                      5 
    ##                 Encino                Escalon              Escondido 
    ##                     10                      4                     20 
    ##                Esparto                  Essex                   Etna 
    ##                      4                      4                      4 
    ##                 Eureka                 Exeter              Fair Oaks 
    ##                      8                      4                      4 
    ##                Fairfax              Fairfield       Fall River Mills 
    ##                      4                      4                      4 
    ##              Fallbrook           Farmersville             Farmington 
    ##                      5                      4                      4 
    ##               Fawnskin                Fellows                 Felton 
    ##                      4                      4                      4 
    ##               Ferndale             Fiddletown         Fields Landing 
    ##                      4                      4                      4 
    ##               Fillmore              Firebaugh              Fish Camp 
    ##                      4                      4                      4 
    ##            Five Points               Flournoy                 Folsom 
    ##                      4                      4                      4 
    ##                Fontana         Foothill Ranch             Forbestown 
    ##                     12                      4                      4 
    ##           Forest Falls          Forest Knolls           Forest Ranch 
    ##                      4                      4                      4 
    ##             Foresthill            Forestville        Forks Of Salmon 
    ##                      4                      4                      4 
    ##           Fort Bidwell             Fort Bragg             Fort Irwin 
    ##                      4                      4                      4 
    ##             Fort Jones                Fortuna        Fountain Valley 
    ##                      4                      4                      4 
    ##                 Fowler           Frazier Park                Freedom 
    ##                      4                      8                      4 
    ##                Fremont            French Camp           French Gulch 
    ##                     16                      4                      4 
    ##                 Fresno                 Friant              Fullerton 
    ##                     64                      4                     16 
    ##                 Fulton                   Galt            Garberville 
    ##                      4                      4                      4 
    ##           Garden Grove          Garden Valley                Gardena 
    ##                     20                      4                     15 
    ##                Gasquet                Gazelle             Georgetown 
    ##                      4                      4                      4 
    ##                 Gerber            Geyserville                 Gilroy 
    ##                      4                      4                      4 
    ##             Glen Ellen                Glencoe               Glendale 
    ##                      4                      4                     40 
    ##               Glendora              Glenhaven                  Glenn 
    ##                     10                      4                      4 
    ##             Glennville               Gold Run                 Goleta 
    ##                      4                      4                      4 
    ##               Gonzales          Goodyears Bar          Granada Hills 
    ##                      4                      4                      5 
    ##          Grand Terrace            Granite Bay           Grass Valley 
    ##                      4                      4                      8 
    ##                 Graton      Green Valley Lake              Greenbrae 
    ##                      4                      4                      4 
    ##             Greenfield              Greenview             Greenville 
    ##                      4                      4                      4 
    ##              Greenwood                Grenada                Gridley 
    ##                      4                      4                      4 
    ##                 Grimes          Grizzly Flats              Groveland 
    ##                      4                      4                      4 
    ##           Grover Beach              Guadalupe                Gualala 
    ##                      4                      4                      4 
    ##                 Guatay            Guerneville                 Guinda 
    ##                      5                      4                      4 
    ##                Gustine       Hacienda Heights          Half Moon Bay 
    ##                      4                      5                      4 
    ##          Hamilton City                Hanford             Happy Camp 
    ##                      4                      4                      4 
    ##            Harbor City              Hat Creek         Hathaway Pines 
    ##                      5                      4                      4 
    ##       Hawaiian Gardens              Hawthorne                Hayfork 
    ##                      5                      5                      4 
    ##                Hayward             Healdsburg                  Heber 
    ##                     16                      4                      5 
    ##              Helendale                   Helm                  Hemet 
    ##                      4                      4                     12 
    ##                 Herald               Hercules                Herlong 
    ##                      4                      4                      4 
    ##          Hermosa Beach               Hesperia                Hickman 
    ##                      5                      4                      4 
    ##               Highland                 Hilmar                Hinkley 
    ##                      4                      4                      4 
    ##              Hollister              Holtville               Homeland 
    ##                      4                      5                      4 
    ##               Homewood               Honeydew                   Hood 
    ##                      4                      4                      4 
    ##                  Hoopa                Hopland              Hornbrook 
    ##                      4                      4                      4 
    ##               Hornitos                Hughson                   Hume 
    ##                      4                      4                      4 
    ##       Huntington Beach        Huntington Park                  Huron 
    ##                     16                      5                      4 
    ##                Hyampom             Hydesville              Idyllwild 
    ##                      4                      4                      4 
    ##                    Igo               Imperial         Imperial Beach 
    ##                      4                      5                      5 
    ##           Independence           Indian Wells                  Indio 
    ##                      4                      5                     10 
    ##              Inglewood              Inverness               Inyokern 
    ##                     25                      4                      4 
    ##                   Ione                 Irvine                Isleton 
    ##                      4                     28                      4 
    ##                Ivanhoe                Jackson                Jacumba 
    ##                      4                      4                      5 
    ##              Jamestown                  Jamul             Janesville 
    ##                      4                      5                      4 
    ##                 Jenner           Johannesburg                  Jolon 
    ##                      4                      4                      4 
    ##            Joshua Tree                 Julian          Junction City 
    ##                      5                      5                      4 
    ##              June Lake                 Keeler                  Keene 
    ##                      4                      4                      4 
    ##            Kelseyville                Kenwood                 Kerman 
    ##                      4                      4                      4 
    ##              Kernville         Kettleman City                  Keyes 
    ##                      4                      4                      4 
    ##              King City            Kings Beach              Kingsburg 
    ##                      4                      4                      4 
    ##               Kirkwood                Klamath          Klamath River 
    ##                      4                      4                      4 
    ##               Kneeland        Knights Landing                 Korbel 
    ##                      4                      4                      4 
    ##                 Kyburz   La Canada Flintridge           La Crescenta 
    ##                      4                      5                      5 
    ##              La Grange               La Habra               La Honda 
    ##                      4                      5                      4 
    ##               La Jolla                La Mesa              La Mirada 
    ##                      5                     10                      5 
    ##               La Palma              La Puente              La Quinta 
    ##                      5                     10                      5 
    ##               La Verne           Ladera Ranch              Lafayette 
    ##                      5                      4                      4 
    ##           Laguna Beach           Laguna Hills          Laguna Niguel 
    ##                      4                      4                      4 
    ##              Lagunitas         Lake Arrowhead              Lake City 
    ##                      4                      4                      4 
    ##          Lake Elsinore            Lake Forest            Lake Hughes 
    ##                      8                      4                      4 
    ##          Lake Isabella               Lakehead               Lakeport 
    ##                      4                      4                      4 
    ##              Lakeshore               Lakeside               Lakewood 
    ##                      4                      5                     15 
    ##                 Lamont              Lancaster                Landers 
    ##                      4                     12                      5 
    ##               Larkspur                Lathrop                  Laton 
    ##                      4                      4                      4 
    ##               Lawndale            Laytonville               Le Grand 
    ##                      5                      4                      4 
    ##                  Lebec             Lee Vining                Leggett 
    ##                      4                      4                      4 
    ##             Lemon Cove            Lemon Grove                Lemoore 
    ##                      4                      5                      4 
    ##               Lewiston                 Likely                Lincoln 
    ##                      4                      4                      4 
    ##                 Linden                Lindsay             Litchfield 
    ##                      4                      4                      4 
    ##           Little River             Littlerock               Live Oak 
    ##                      4                      4                      4 
    ##              Livermore             Livingston                  Llano 
    ##                      4                      4                      4 
    ##              Lockeford               Lockwood                   Lodi 
    ##                      4                      4                      8 
    ##                 Loleta             Loma Linda               Loma Mar 
    ##                      4                      4                      4 
    ##                 Lomita                 Lompoc              Lone Pine 
    ##                      5                      8                      4 
    ##              Long Barn             Long Beach                Lookout 
    ##                      4                     60                      4 
    ##                 Loomis           Los Alamitos             Los Alamos 
    ##                      4                      5                      4 
    ##              Los Altos            Los Angeles              Los Banos 
    ##                      8                    305                      4 
    ##              Los Gatos            Los Molinos             Los Olivos 
    ##                     12                      4                      4 
    ##               Los Osos             Lost Hills                  Lotus 
    ##                      4                      4                      4 
    ##             Lower Lake               Loyalton                Lucerne 
    ##                      4                      4                      4 
    ##         Lucerne Valley                 Ludlow                Lynwood 
    ##                      4                      4                      5 
    ##            Lytle Creek                Macdoel              Mad River 
    ##                      4                      4                      4 
    ##               Madeline                 Madera                Madison 
    ##                      4                      8                      4 
    ##                Magalia                 Malibu          Mammoth Lakes 
    ##                      4                     10                      4 
    ##             Manchester        Manhattan Beach                Manteca 
    ##                      4                      5                      8 
    ##                 Manton March Air Reserve Base               Maricopa 
    ##                      4                      4                      4 
    ##                 Marina         Marina Del Rey               Mariposa 
    ##                      4                      5                      4 
    ##           Markleeville               Marshall               Martinez 
    ##                      4                      4                      4 
    ##             Marysville                 Mather                Maxwell 
    ##                      4                      4                      4 
    ##                Maywood             Mc Farland            Mc Kittrick 
    ##                      5                      4                      4 
    ##               Mcarthur                Mccloud          Mckinleyville 
    ##                      4                      4                      4 
    ##          Meadow Valley           Meadow Vista                  Mecca 
    ##                      4                      4                      5 
    ##              Mendocino                Mendota                Menifee 
    ##                      4                      4                      4 
    ##             Menlo Park                Mentone                 Merced 
    ##                      4                      4                      8 
    ##               Meridian         Mi Wuk Village             Middletown 
    ##                      4                      4                      4 
    ##               Midpines            Midway City                Milford 
    ##                      4                      4                      4 
    ##             Mill Creek            Mill Valley               Millbrae 
    ##                      4                      4                      4 
    ##              Millville               Milpitas                Mineral 
    ##                      4                      4                      4 
    ##              Mira Loma              Miramonte                Miranda 
    ##                      5                      4                      4 
    ##          Mission Hills          Mission Viejo                Modesto 
    ##                      5                      8                     28 
    ##                 Mojave         Mokelumne Hill               Monrovia 
    ##                      4                      4                      5 
    ##               Montague                Montara              Montclair 
    ##                      4                      4                      5 
    ##              Monte Rio             Montebello               Monterey 
    ##                      4                      5                      4 
    ##          Monterey Park       Montgomery Creek               Montrose 
    ##                     10                      4                      5 
    ##               Moorpark                 Moraga          Moreno Valley 
    ##                      4                      4                     16 
    ##            Morgan Hill         Morongo Valley              Morro Bay 
    ##                      4                      5                      4 
    ##             Moss Beach           Moss Landing         Mount Hamilton 
    ##                      4                      4                      4 
    ##           Mount Hermon           Mount Laguna           Mount Shasta 
    ##                      4                      5                      4 
    ##        Mountain Center         Mountain Ranch          Mountain View 
    ##                      4                      4                     12 
    ##               Mt Baldy                Murphys               Murrieta 
    ##                      5                      4                      8 
    ##             Myers Flat                   Napa          National City 
    ##                      4                      8                      5 
    ##                Navarro                Needles            Nevada City 
    ##                      4                      4                      4 
    ##             New Cuyama                 Newark       Newberry Springs 
    ##                      4                      4                      4 
    ##           Newbury Park              Newcastle                Newhall 
    ##                      5                      4                      5 
    ##                 Newman          Newport Beach          Newport Coast 
    ##                      4                     16                      4 
    ##                Nicasio                   Nice               Nicolaus 
    ##                      4                      4                      4 
    ##                 Niland                 Nipomo                 Nipton 
    ##                      5                      4                      4 
    ##                  Norco             North Fork        North Highlands 
    ##                      4                      4                      4 
    ##            North Hills        North Hollywood     North Palm Springs 
    ##                      5                     20                      5 
    ##         North San Juan             Northridge                Norwalk 
    ##                      4                     10                      5 
    ##                 Novato               Nubieber                  Nuevo 
    ##                     12                      4                      4 
    ##                O Neals               Oak Park                Oak Run 
    ##                      4                      5                      4 
    ##               Oak View                Oakdale               Oakhurst 
    ##                      4                      4                      4 
    ##                Oakland                 Oakley             Occidental 
    ##                     52                      4                      4 
    ##                 Oceano              Oceanside               Ocotillo 
    ##                      4                     15                      5 
    ##                   Ojai                Olancha            Old Station 
    ##                      4                      4                      4 
    ##                  Olema             Olivehurst         Olympic Valley 
    ##                      4                      4                      4 
    ##                Ontario                   Onyx                 Orange 
    ##                     15                      4                     20 
    ##            Orange Cove             Orangevale           Oregon House 
    ##                      4                      4                      4 
    ##                  Orick                 Orinda                 Orland 
    ##                      4                      4                      4 
    ##                Orleans             Oro Grande                  Orosi 
    ##                      4                      4                      4 
    ##               Oroville                 Oxnard          Pacific Grove 
    ##                      8                     12                      4 
    ##      Pacific Palisades               Pacifica                Pacoima 
    ##                      5                      4                      5 
    ##               Paicines                   Pala                Palermo 
    ##                      4                      5                      4 
    ##            Palm Desert           Palm Springs               Palmdale 
    ##                     10                     10                     16 
    ##              Palo Alto             Palo Cedro             Palo Verde 
    ##                     16                      4                      5 
    ##       Palomar Mountain Palos Verdes Peninsula          Panorama City 
    ##                      5                      5                      5 
    ##               Paradise              Paramount             Parker Dam 
    ##                      4                      5                      5 
    ##                Parlier               Pasadena               Paskenta 
    ##                      4                     30                      4 
    ##            Paso Robles              Patterson           Pauma Valley 
    ##                      4                      4                      5 
    ##           Paynes Creek            Pearblossom           Pebble Beach 
    ##                      4                      4                      4 
    ##            Penn Valley              Penngrove                 Penryn 
    ##                      4                      4                      4 
    ##                 Perris              Pescadero               Petaluma 
    ##                      8                      4                      8 
    ##               Petrolia                 Phelan          Phillipsville 
    ##                      4                      4                      4 
    ##                  Philo            Pico Rivera                 Piercy 
    ##                      4                      5                      4 
    ##             Pilot Hill             Pine Grove            Pine Valley 
    ##                      4                      4                      5 
    ##              Pinecrest                 Pinole            Pinon Hills 
    ##                      4                      4                      4 
    ##                Pioneer            Pioneertown                   Piru 
    ##                      4                      5                      4 
    ##            Pismo Beach              Pittsburg                 Pixley 
    ##                      4                      4                      4 
    ##              Placentia            Placerville                Planada 
    ##                      4                      4                      4 
    ##                Platina          Playa Del Rey         Pleasant Grove 
    ##                      4                      5                      4 
    ##          Pleasant Hill             Pleasanton               Plymouth 
    ##                      4                      8                      4 
    ##            Point Arena    Point Reyes Station          Pollock Pines 
    ##                      4                      4                      4 
    ##                 Pomona            Pope Valley             Port Costa 
    ##                     15                      4                      4 
    ##           Port Hueneme           Porter Ranch            Porterville 
    ##                      4                      5                      4 
    ##                Portola         Portola Valley                  Posey 
    ##                      4                      4                      4 
    ##                Potrero          Potter Valley                  Poway 
    ##                      5                      4                      5 
    ##                Prather              Princeton                 Quincy 
    ##                      4                      4                      4 
    ##            Raisin City                 Ramona               Ranchita 
    ##                      4                      5                      5 
    ##         Rancho Cordova       Rancho Cucamonga          Rancho Mirage 
    ##                      8                     20                      5 
    ##    Rancho Palos Verdes        Rancho Santa Fe Rancho Santa Margarita 
    ##                      5                     10                      4 
    ##              Randsburg              Ravendale                Raymond 
    ##                      4                      4                      4 
    ##              Red Bluff               Redcrest                Redding 
    ##                      4                      4                     12 
    ##               Redlands          Redondo Beach                 Redway 
    ##                      8                     10                      4 
    ##           Redwood City         Redwood Valley                Reedley 
    ##                     16                      4                      4 
    ##                 Rescue                 Reseda                 Rialto 
    ##                      4                      5                      8 
    ##              Richgrove               Richmond               Richvale 
    ##                      4                     12                      4 
    ##             Ridgecrest               Rio Dell              Rio Linda 
    ##                      4                      4                      4 
    ##               Rio Nido                Rio Oso              Rio Vista 
    ##                      4                      4                      4 
    ##                  Ripon            River Pines              Riverbank 
    ##                      4                      4                      4 
    ##              Riverdale              Riverside                Rocklin 
    ##                      4                     32                      8 
    ##                  Rodeo           Rohnert Park               Rosamond 
    ##                      4                      4                      4 
    ##               Rosemead              Roseville        Rough And Ready 
    ##                      5                     12                      4 
    ##         Round Mountain        Rowland Heights        Running Springs 
    ##                      4                      5                      4 
    ##             Sacramento           Saint Helena                 Salida 
    ##                    108                      4                      4 
    ##                Salinas            Salton City                 Salyer 
    ##                     20                      5                      4 
    ##                  Samoa            San Andreas            San Anselmo 
    ##                      4                      4                      4 
    ##               San Ardo         San Bernardino              San Bruno 
    ##                      4                     28                      4 
    ##             San Carlos           San Clemente              San Diego 
    ##                      4                      8                    150 
    ##              San Dimas           San Fernando          San Francisco 
    ##                      5                      5                    104 
    ##            San Gabriel           San Geronimo           San Gregorio 
    ##                     10                      4                      4 
    ##            San Jacinto            San Joaquin               San Jose 
    ##                      8                      4                    112 
    ##      San Juan Bautista    San Juan Capistrano            San Leandro 
    ##                      4                      4                     12 
    ##            San Lorenzo              San Lucas        San Luis Obispo 
    ##                      4                      4                      8 
    ##             San Marcos             San Marino             San Martin 
    ##                     10                      5                      4 
    ##              San Mateo             San Miguel              San Pablo 
    ##                     16                      4                      4 
    ##              San Pedro            San Quentin             San Rafael 
    ##                     10                      4                      8 
    ##              San Ramon             San Simeon             San Ysidro 
    ##                      4                      4                      5 
    ##                 Sanger              Santa Ana          Santa Barbara 
    ##                      4                     24                     28 
    ##            Santa Clara          Santa Clarita             Santa Cruz 
    ##                     12                      5                     16 
    ##       Santa Fe Springs        Santa Margarita            Santa Maria 
    ##                      5                      4                     12 
    ##           Santa Monica            Santa Paula             Santa Rosa 
    ##                     25                      4                     24 
    ##             Santa Ynez           Santa Ysabel                 Santee 
    ##                      4                      5                      5 
    ##               Saratoga              Sausalito                 Scotia 
    ##                      4                      4                      4 
    ##              Scott Bar          Scotts Valley             Seal Beach 
    ##                      4                      4                      5 
    ##                Seaside             Sebastopol                 Seeley 
    ##                      4                      4                      5 
    ##           Seiad Valley                  Selma  Sequoia National Park 
    ##                      4                      4                      4 
    ##                Shafter                Shandon                 Shasta 
    ##                      4                      4                      4 
    ##            Shasta Lake            Shaver Lake            Sheep Ranch 
    ##                      4                      4                      4 
    ##               Sheridan           Sherman Oaks        Shingle Springs 
    ##                      4                     10                      4 
    ##            Shingletown               Shoshone            Sierra City 
    ##                      4                      4                      4 
    ##           Sierra Madre            Sierraville              Silverado 
    ##                      5                      4                      4 
    ##            Simi Valley            Sloughhouse             Smartville 
    ##                      8                      4                      4 
    ##            Smith River               Snelling           Soda Springs 
    ##                      4                      4                      4 
    ##           Solana Beach                Soledad                Solvang 
    ##                      5                      4                      4 
    ##               Somerset              Somes Bar                  Somis 
    ##                      4                      4                      4 
    ##                 Sonoma                 Sonora                 Soquel 
    ##                      4                      4                      4 
    ##           Soulsbyville        South Dos Palos         South El Monte 
    ##                      4                      4                      5 
    ##             South Gate       South Lake Tahoe         South Pasadena 
    ##                      5                      4                      5 
    ##    South San Francisco              Spreckels          Spring Valley 
    ##                      4                      4                     10 
    ##            Springville           Squaw Valley               Standish 
    ##                      4                      4                      4 
    ##               Stanford                Stanton        Stevenson Ranch 
    ##                      4                      5                      5 
    ##              Stevinson          Stinson Beach          Stirling City 
    ##                      4                      4                      4 
    ##               Stockton              Stonyford              Stratford 
    ##                     44                      4                      4 
    ##             Strathmore      Strawberry Valley            Studio City 
    ##                      4                      4                      5 
    ##              Sugarloaf            Suisun City                Sultana 
    ##                      4                      4                      4 
    ##             Summerland               Sun City             Sun Valley 
    ##                      4                     12                      5 
    ##                Sunland              Sunnyvale                  Sunol 
    ##                      5                     12                      4 
    ##           Sunset Beach               Surfside             Susanville 
    ##                      5                      5                      4 
    ##                 Sutter           Sutter Creek                 Sylmar 
    ##                      4                      4                      5 
    ##                   Taft             Tahoe City            Tahoe Vista 
    ##                      4                      4                      4 
    ##                 Tahoma                Tarzana           Taylorsville 
    ##                      4                      5                      4 
    ##                 Tecate                 Tecopa              Tehachapi 
    ##                      5                      4                      4 
    ##                 Tehama               Temecula            Temple City 
    ##                      4                     12                      5 
    ##              Templeton                  Termo            Terra Bella 
    ##                      4                      4                      4 
    ##          The Sea Ranch                Thermal               Thornton 
    ##                      4                      5                      4 
    ##          Thousand Oaks         Thousand Palms           Three Rivers 
    ##                     10                      5                      4 
    ##                 Tipton              Tollhouse                Tomales 
    ##                      4                      4                      4 
    ##                Topanga                  Topaz               Torrance 
    ##                      5                      4                     25 
    ##         Trabuco Canyon                  Tracy           Tranquillity 
    ##                      4                      4                      4 
    ##                 Traver             Travis Afb               Trinidad 
    ##                      4                      4                      4 
    ##         Trinity Center                  Trona                Truckee 
    ##                      4                      4                      4 
    ##                Tujunga                 Tulare               Tulelake 
    ##                      5                      4                      4 
    ##               Tuolumne                 Tupman                Turlock 
    ##                      4                      4                      8 
    ##                 Tustin                  Twain            Twain Harte 
    ##                      8                      4                      4 
    ##       Twentynine Palms           Twin Bridges                  Ukiah 
    ##                     10                      4                      4 
    ##             Union City                 Upland             Upper Lake 
    ##                      4                     10                      4 
    ##              Vacaville               Valencia              Vallecito 
    ##                      8                     10                      4 
    ##                Vallejo          Valley Center            Valley Ford 
    ##                     16                      5                      4 
    ##         Valley Springs         Valley Village               Valyermo 
    ##                      4                      5                      4 
    ##               Van Nuys                 Venice                Ventura 
    ##                     20                      5                     12 
    ##               Vernalis            Victorville                  Vidal 
    ##                      4                      8                      5 
    ##             Villa Park                   Vina                Visalia 
    ##                      4                      4                     12 
    ##                  Vista                Volcano                Wallace 
    ##                     10                      4                      4 
    ##                 Walnut           Walnut Creek           Walnut Grove 
    ##                      5                     12                      4 
    ##         Warner Springs                  Wasco             Washington 
    ##                      5                      4                      4 
    ##              Waterford            Watsonville            Weaverville 
    ##                      4                      4                      4 
    ##                   Weed                 Weimar                 Weldon 
    ##                      4                      4                      4 
    ##                 Wendel                  Weott            West Covina 
    ##                      4                      4                     15 
    ##             West Hills         West Hollywood             West Point 
    ##                      5                      5                      4 
    ##        West Sacramento       Westlake Village                Westley 
    ##                      8                      5                      4 
    ##            Westminster            Westmorland               Westport 
    ##                      4                      5                      4 
    ##               Westwood              Wheatland            White Water 
    ##                      4                      4                      5 
    ##             Whitethorn               Whitmore               Whittier 
    ##                      4                      4                     30 
    ##               Wildomar               Williams                Willits 
    ##                      4                      4                      4 
    ##           Willow Creek                Willows             Wilmington 
    ##                      4                      4                      5 
    ##            Wilseyville                 Wilton             Winchester 
    ##                      4                      4                      4 
    ##                Windsor               Winnetka            Winterhaven 
    ##                      4                      5                      5 
    ##                Winters                 Winton                 Wishon 
    ##                      4                      4                      4 
    ##         Witter Springs        Wofford Heights               Woodacre 
    ##                      4                      4                      4 
    ##             Woodbridge               Woodlake               Woodland 
    ##                      4                      4                      8 
    ##         Woodland Hills                  Woody             Wrightwood 
    ##                     10                      4                      4 
    ##                  Yermo            Yorba Linda              Yorkville 
    ##                      4                      8                      4 
    ## Yosemite National Park             Yountville                  Yreka 
    ##                      4                      4                      4 
    ##              Yuba City                Yucaipa           Yucca Valley 
    ##                      8                      4                      5 
    ##                  Zenia 
    ##                      4 
    ## 
    ## Frequency table for variable: Zip_Code 
    ## 
    ## 90001 90002 90003 90004 90005 90006 90007 90008 90010 90011 90012 90013 90014 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 90015 90016 90017 90018 90019 90020 90021 90022 90023 90024 90025 90026 90027 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 90028 90029 90031 90032 90033 90034 90035 90036 90037 90038 90039 90040 90041 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 90042 90043 90044 90045 90046 90047 90048 90049 90056 90057 90058 90059 90061 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 90062 90063 90064 90065 90066 90067 90068 90069 90071 90077 90201 90210 90211 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 90212 90220 90221 90222 90230 90232 90240 90241 90242 90245 90247 90248 90249 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 90250 90254 90255 90260 90262 90263 90265 90266 90270 90272 90274 90275 90277 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 90278 90280 90290 90291 90292 90293 90301 90302 90303 90304 90305 90401 90402 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 90403 90404 90405 90501 90502 90503 90504 90505 90601 90602 90603 90604 90605 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 90606 90620 90621 90623 90630 90631 90638 90640 90650 90660 90670 90680 90701 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 90703 90704 90706 90710 90712 90713 90715 90716 90717 90720 90723 90731 90732 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 90740 90742 90743 90744 90745 90746 90802 90803 90804 90805 90806 90807 90808 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 90810 90813 90814 90815 90822 91001 91006 91007 91010 91011 91016 91020 91024 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 91030 91040 91042 91101 91103 91104 91105 91106 91107 91108 91201 91202 91203 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 91204 91205 91206 91207 91208 91214 91301 91302 91303 91304 91306 91307 91311 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 91316 91320 91321 91324 91325 91326 91331 91335 91340 91342 91343 91344 91345 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 91350 91351 91352 91354 91355 91356 91360 91361 91362 91364 91367 91377 91381 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 91384 91401 91402 91403 91405 91406 91411 91423 91436 91501 91502 91504 91505 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 91506 91601 91602 91604 91605 91606 91607 91701 91702 91706 91709 91710 91711 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 91722 91723 91724 91730 91731 91732 91733 91737 91739 91740 91741 91744 91745 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 91746 91748 91750 91752 91754 91755 91759 91761 91762 91763 91764 91765 91766 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 91767 91768 91770 91773 91775 91776 91780 91784 91786 91789 91790 91791 91792 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 91801 91803 91901 91902 91905 91906 91910 91911 91913 91914 91915 91916 91917 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 91931 91932 91934 91935 91941 91942 91945 91948 91950 91962 91963 91977 91978 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 91980 92003 92004 92007 92008 92009 92014 92019 92020 92021 92024 92025 92026 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 92027 92028 92029 92036 92037 92040 92054 92056 92057 92059 92060 92061 92064 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 92065 92066 92067 92069 92070 92071 92075 92078 92082 92083 92084 92086 92091 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 92101 92102 92103 92104 92105 92106 92107 92108 92109 92110 92111 92113 92114 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 92115 92116 92117 92118 92119 92120 92121 92122 92123 92124 92126 92127 92128 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 92129 92130 92131 92139 92154 92173 92201 92203 92210 92211 92220 92223 92225 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 92227 92230 92231 92233 92234 92236 92239 92240 92241 92242 92243 92249 92250 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 92251 92252 92253 92254 92256 92257 92258 92259 92260 92262 92264 92266 92267 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 92268 92270 92273 92274 92275 92276 92277 92278 92280 92281 92282 92283 92284 
    ##     5     5     5     5     5     5     5     5     5     5     5     5     5 
    ## 92285 92301 92304 92305 92307 92308 92309 92310 92311 92313 92314 92315 92316 
    ##     5     5     5     5     5     5     4     4     4     4     4     4     4 
    ## 92320 92321 92324 92325 92327 92328 92332 92333 92335 92336 92337 92338 92339 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 92341 92342 92345 92346 92347 92352 92354 92356 92358 92359 92363 92364 92365 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 92368 92371 92372 92373 92374 92376 92377 92382 92384 92386 92389 92392 92394 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 92397 92398 92399 92401 92404 92405 92407 92408 92410 92411 92501 92503 92504 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 92505 92506 92507 92508 92509 92518 92530 92532 92536 92539 92543 92544 92545 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 92548 92549 92551 92553 92555 92557 92561 92562 92563 92567 92570 92571 92582 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 92583 92584 92585 92586 92587 92590 92591 92592 92595 92596 92602 92604 92606 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 92610 92612 92614 92618 92620 92624 92625 92626 92627 92629 92630 92646 92647 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 92648 92649 92651 92653 92655 92656 92657 92660 92661 92662 92663 92672 92673 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 92675 92676 92677 92679 92683 92688 92691 92692 92694 92701 92703 92704 92705 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 92706 92707 92708 92780 92782 92801 92802 92804 92805 92806 92807 92808 92821 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 92823 92831 92832 92833 92835 92840 92841 92843 92844 92845 92860 92861 92865 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 92866 92867 92868 92869 92870 92879 92880 92881 92882 92883 92886 92887 93001 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93003 93004 93010 93012 93013 93015 93021 93022 93023 93030 93033 93035 93040 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93041 93060 93063 93065 93066 93067 93101 93103 93105 93108 93109 93110 93111 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93117 93201 93202 93203 93204 93205 93206 93207 93208 93210 93212 93215 93218 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93219 93221 93222 93223 93224 93225 93226 93230 93234 93235 93238 93239 93240 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93241 93242 93243 93244 93245 93247 93249 93250 93251 93252 93254 93255 93256 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93257 93260 93261 93262 93263 93265 93266 93267 93268 93270 93271 93272 93274 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93276 93277 93280 93283 93285 93286 93287 93291 93292 93301 93304 93305 93306 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93307 93308 93309 93311 93312 93313 93401 93402 93405 93420 93422 93424 93426 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93427 93428 93429 93430 93432 93433 93434 93436 93437 93440 93441 93442 93444 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93445 93446 93449 93450 93451 93452 93453 93454 93455 93458 93460 93461 93463 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93465 93501 93505 93510 93512 93513 93514 93516 93517 93518 93522 93523 93526 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93527 93528 93529 93530 93531 93532 93534 93535 93536 93541 93543 93544 93545 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93546 93549 93550 93551 93552 93553 93554 93555 93560 93561 93562 93563 93591 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93601 93602 93603 93604 93605 93606 93608 93609 93610 93611 93612 93614 93615 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93616 93618 93620 93621 93622 93623 93624 93625 93626 93627 93628 93630 93631 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93634 93635 93637 93638 93640 93641 93643 93644 93645 93646 93647 93648 93650 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93651 93652 93653 93654 93656 93657 93660 93662 93664 93665 93666 93667 93668 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93669 93673 93675 93701 93702 93703 93704 93705 93706 93710 93711 93720 93721 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93722 93725 93726 93727 93728 93901 93905 93906 93907 93908 93920 93921 93923 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93924 93925 93926 93927 93928 93930 93932 93933 93940 93950 93953 93954 93955 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 93960 93962 94002 94005 94010 94014 94015 94019 94020 94021 94022 94024 94025 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 94027 94028 94030 94037 94038 94040 94041 94043 94044 94060 94061 94062 94063 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 94065 94066 94070 94074 94080 94086 94087 94089 94102 94103 94104 94105 94107 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 94108 94109 94110 94111 94112 94114 94115 94116 94117 94118 94121 94122 94123 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 94124 94127 94129 94130 94131 94132 94133 94134 94301 94303 94304 94305 94306 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 94401 94402 94403 94404 94501 94502 94506 94507 94508 94509 94510 94511 94512 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 94513 94514 94515 94517 94518 94519 94520 94521 94523 94525 94526 94530 94533 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 94535 94536 94538 94539 94541 94542 94544 94545 94546 94547 94549 94550 94552 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 94553 94555 94556 94558 94559 94560 94561 94563 94564 94565 94566 94567 94568 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 94569 94571 94572 94574 94576 94577 94578 94579 94580 94583 94585 94586 94587 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 94588 94589 94590 94591 94592 94595 94596 94598 94599 94601 94602 94603 94605 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 94606 94607 94608 94609 94610 94611 94612 94618 94619 94621 94702 94703 94704 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 94705 94706 94707 94708 94709 94710 94801 94803 94804 94805 94806 94901 94903 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 94904 94920 94922 94923 94924 94925 94928 94929 94930 94931 94933 94937 94938 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 94939 94940 94941 94945 94946 94947 94949 94950 94951 94952 94954 94956 94960 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 94963 94964 94965 94970 94971 94972 94973 95002 95003 95004 95005 95006 95007 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95008 95010 95012 95014 95017 95018 95019 95020 95023 95030 95032 95033 95035 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95037 95039 95041 95043 95045 95046 95050 95051 95054 95060 95062 95064 95065 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95066 95070 95073 95076 95110 95111 95112 95113 95116 95117 95118 95119 95120 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95121 95122 95123 95124 95125 95126 95127 95128 95129 95130 95131 95132 95133 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95134 95135 95136 95138 95139 95140 95148 95202 95203 95204 95205 95206 95207 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95209 95210 95212 95215 95219 95220 95222 95223 95224 95225 95226 95227 95228 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95230 95231 95232 95233 95236 95237 95240 95242 95245 95246 95247 95249 95250 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95251 95252 95254 95255 95257 95258 95301 95303 95305 95306 95307 95310 95311 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95312 95313 95315 95316 95317 95318 95320 95321 95322 95323 95324 95325 95326 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95327 95328 95329 95330 95333 95334 95335 95336 95337 95338 95340 95345 95346 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95348 95350 95351 95354 95355 95356 95357 95358 95360 95361 95363 95364 95365 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95366 95367 95368 95369 95370 95372 95374 95376 95379 95380 95382 95383 95385 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95386 95387 95388 95389 95401 95403 95404 95405 95407 95409 95410 95412 95415 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95417 95420 95421 95422 95423 95425 95426 95427 95428 95429 95430 95431 95432 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95436 95437 95439 95441 95442 95443 95444 95445 95446 95448 95449 95450 95451 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95452 95453 95454 95456 95457 95458 95459 95460 95461 95462 95463 95464 95465 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95466 95468 95469 95470 95471 95472 95476 95482 95485 95488 95490 95492 95493 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95494 95497 95501 95503 95511 95514 95519 95521 95524 95525 95526 95527 95528 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95531 95536 95537 95540 95542 95543 95545 95546 95547 95548 95549 95550 95551 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95552 95553 95554 95555 95556 95558 95559 95560 95562 95563 95564 95565 95567 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95568 95569 95570 95571 95573 95585 95587 95589 95595 95601 95602 95603 95605 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95606 95607 95608 95610 95612 95614 95615 95616 95618 95619 95620 95621 95623 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95624 95625 95626 95627 95628 95629 95630 95631 95632 95633 95634 95635 95636 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95637 95638 95639 95640 95641 95642 95645 95646 95648 95650 95651 95653 95655 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95658 95659 95660 95661 95662 95663 95664 95665 95666 95667 95668 95669 95670 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95672 95673 95674 95675 95677 95678 95681 95682 95683 95684 95685 95686 95687 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95688 95689 95690 95691 95692 95693 95694 95695 95701 95703 95709 95713 95714 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95715 95717 95720 95721 95722 95726 95728 95735 95736 95742 95746 95747 95758 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95762 95765 95776 95814 95815 95816 95817 95818 95819 95820 95821 95822 95823 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95824 95825 95826 95827 95828 95829 95830 95831 95832 95833 95834 95835 95837 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95838 95841 95842 95843 95864 95901 95903 95910 95912 95914 95916 95917 95918 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95919 95920 95922 95923 95925 95926 95928 95930 95932 95934 95935 95936 95937 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95938 95939 95941 95942 95943 95944 95945 95946 95947 95948 95949 95950 95951 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95953 95954 95955 95956 95957 95959 95960 95961 95962 95963 95965 95966 95968 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95969 95970 95971 95973 95974 95975 95977 95978 95979 95981 95982 95983 95984 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 95986 95987 95988 95991 95993 96001 96002 96003 96006 96007 96008 96009 96010 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 96011 96013 96014 96015 96016 96017 96019 96020 96021 96022 96023 96024 96025 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 96027 96028 96029 96031 96032 96033 96034 96035 96037 96038 96039 96040 96041 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 96044 96046 96047 96048 96050 96051 96052 96054 96055 96056 96057 96058 96059 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 96061 96062 96063 96064 96065 96067 96068 96069 96071 96073 96074 96075 96076 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 96080 96084 96085 96086 96087 96088 96090 96091 96092 96093 96094 96096 96097 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 96101 96103 96104 96105 96106 96107 96108 96109 96110 96112 96113 96114 96115 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 96116 96117 96118 96119 96120 96121 96122 96123 96124 96125 96126 96128 96130 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 96132 96133 96134 96136 96137 96140 96141 96142 96143 96145 96146 96148 96150 
    ##     4     4     4     4     4     4     4     4     4     4     4     4     4 
    ## 96161 
    ##     4 
    ## 
    ## Frequency table for variable: Gender 
    ## 
    ## Female   Male 
    ##   3488   3555 
    ## 
    ## Frequency table for variable: Senior_Citizen 
    ## 
    ##   No  Yes 
    ## 5901 1142 
    ## 
    ## Frequency table for variable: Partner 
    ## 
    ##   No  Yes 
    ## 3641 3402 
    ## 
    ## Frequency table for variable: Dependents 
    ## 
    ##   No  Yes 
    ## 5416 1627 
    ## 
    ## Frequency table for variable: Phone_Service 
    ## 
    ##   No  Yes 
    ##  682 6361 
    ## 
    ## Frequency table for variable: Multiple_Lines 
    ## 
    ##               No No phone service              Yes 
    ##             3390              682             2971 
    ## 
    ## Frequency table for variable: Internet_Service 
    ## 
    ##         DSL Fiber optic          No 
    ##        2421        3096        1526 
    ## 
    ## Frequency table for variable: Online_Security 
    ## 
    ##                  No No internet service                 Yes 
    ##                3498                1526                2019 
    ## 
    ## Frequency table for variable: Online_Backup 
    ## 
    ##                  No No internet service                 Yes 
    ##                3088                1526                2429 
    ## 
    ## Frequency table for variable: Device_Protection 
    ## 
    ##                  No No internet service                 Yes 
    ##                3095                1526                2422 
    ## 
    ## Frequency table for variable: Tech_Support 
    ## 
    ##                  No No internet service                 Yes 
    ##                3473                1526                2044 
    ## 
    ## Frequency table for variable: Streaming_TV 
    ## 
    ##                  No No internet service                 Yes 
    ##                2810                1526                2707 
    ## 
    ## Frequency table for variable: Streaming_Movies 
    ## 
    ##                  No No internet service                 Yes 
    ##                2785                1526                2732 
    ## 
    ## Frequency table for variable: Contract 
    ## 
    ## Month-to-month       One year       Two year 
    ##           3875           1473           1695 
    ## 
    ## Frequency table for variable: Paperless_Billing 
    ## 
    ##   No  Yes 
    ## 2872 4171 
    ## 
    ## Frequency table for variable: Payment_Method 
    ## 
    ## Bank transfer (automatic)   Credit card (automatic)          Electronic check 
    ##                      1544                      1522                      2365 
    ##              Mailed check 
    ##                      1612 
    ## 
    ## Frequency table for variable: Churn_Label 
    ## 
    ##   No  Yes 
    ## 5174 1869 
    ## 
    ## Frequency table for variable: Churn_Reason 
    ## 
    ##                                           
    ##                                      5174 
    ##              Attitude of service provider 
    ##                                       135 
    ##                Attitude of support person 
    ##                                       192 
    ##             Competitor had better devices 
    ##                                       130 
    ##              Competitor made better offer 
    ##                                       140 
    ## Competitor offered higher download speeds 
    ##                                       189 
    ##              Competitor offered more data 
    ##                                       162 
    ##                                  Deceased 
    ##                                         6 
    ##                                Don't know 
    ##                                       154 
    ##                        Extra data charges 
    ##                                        57 
    ##  Lack of affordable download/upload speed 
    ##                                        44 
    ##           Lack of self-service on Website 
    ##                                        88 
    ##                 Limited range of services 
    ##                                        44 
    ##                     Long distance charges 
    ##                                        44 
    ##                                     Moved 
    ##                                        53 
    ##                       Network reliability 
    ##                                       103 
    ##          Poor expertise of online support 
    ##                                        19 
    ##           Poor expertise of phone support 
    ##                                        20 
    ##                            Price too high 
    ##                                        98 
    ##                   Product dissatisfaction 
    ##                                       102 
    ##                   Service dissatisfaction 
    ##                                        89

``` r
# Measures of central tendency
# Define numerical variables
numerical_vars <- c("Tenure_Months", "Monthly_Charges", "Total_Charges", 
                    "Churn_Value", "Churn_Score", "CLTV")

# Generate measures of central tendency for each numerical variable
for (var in numerical_vars) {
  cat(paste("Measures of central tendency for variable:", var, "\n"))
  print(summary(churn_data[[var]]))
  cat("\n")
}
```

    ## Measures of central tendency for variable: Tenure_Months 
    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##    0.00    9.00   29.00   32.37   55.00   72.00 
    ## 
    ## Measures of central tendency for variable: Monthly_Charges 
    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   18.25   35.50   70.35   64.76   89.85  118.75 
    ## 
    ## Measures of central tendency for variable: Total_Charges 
    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
    ##    18.8   401.4  1397.5  2283.3  3794.7  8684.8      11 
    ## 
    ## Measures of central tendency for variable: Churn_Value 
    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##  0.0000  0.0000  0.0000  0.2654  1.0000  1.0000 
    ## 
    ## Measures of central tendency for variable: Churn_Score 
    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##     5.0    40.0    61.0    58.7    75.0   100.0 
    ## 
    ## Measures of central tendency for variable: CLTV 
    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##    2003    3469    4527    4400    5380    6500

``` r
#Measures of Distribution

# Load required package
library(e1071)

# Define numerical variables
numerical_vars <- c("Tenure_Months", "Monthly_Charges", "Total_Charges", 
                    "Churn_Value", "Churn_Score", "CLTV")

# Generate measures of distribution for each numerical variable
for (var in numerical_vars) {
  cat(paste("Measures of distribution for variable:", var, "\n"))
  cat("Skewness:", skewness(churn_data[[var]]), "\n")
  cat("Kurtosis:", kurtosis(churn_data[[var]]), "\n")
  cat("\n")
}
```

    ## Measures of distribution for variable: Tenure_Months 
    ## Skewness: 0.2394377 
    ## Kurtosis: -1.387697 
    ## 
    ## Measures of distribution for variable: Monthly_Charges 
    ## Skewness: -0.2204305 
    ## Kurtosis: -1.257714 
    ## 
    ## Measures of distribution for variable: Total_Charges 
    ## Skewness: NA 
    ## Kurtosis: NA 
    ## 
    ## Measures of distribution for variable: Churn_Value 
    ## Skewness: 1.062579 
    ## Kurtosis: -0.8710502 
    ## 
    ## Measures of distribution for variable: Churn_Score 
    ## Skewness: -0.08980172 
    ## Kurtosis: -1.006383 
    ## 
    ## Measures of distribution for variable: CLTV 
    ## Skewness: -0.3114694 
    ## Kurtosis: -0.9348079

``` r
# Measures of Relationship

# Load required package
library(MASS)  # For the chi-square test

# Define variables
numerical_vars <- c("Tenure_Months", "Monthly_Charges", "Total_Charges", 
                    "Churn_Value", "Churn_Score", "CLTV")

categorical_vars <- c("Count", "Country", "State", "City", "Zip_Code", 
                      "Gender", "Senior_Citizen", "Partner", "Dependents",
                      "Phone_Service", "Multiple_Lines", "Internet_Service",
                      "Online_Security", "Online_Backup", "Device_Protection",
                      "Tech_Support", "Streaming_TV", "Streaming_Movies",
                      "Contract", "Paperless_Billing", "Payment_Method",
                      "Churn_Label", "Churn_Reason")

# Compute measures of relationship for numerical variables (correlation)
cat("Correlation coefficients for numerical variables:\n")
```

    ## Correlation coefficients for numerical variables:

``` r
correlation_matrix <- cor(churn_data[, numerical_vars])
print(correlation_matrix)
```

    ##                 Tenure_Months Monthly_Charges Total_Charges Churn_Value
    ## Tenure_Months       1.0000000      0.24789986            NA  -0.3522287
    ## Monthly_Charges     0.2478999      1.00000000            NA   0.1933564
    ## Total_Charges              NA              NA             1          NA
    ## Churn_Value        -0.3522287      0.19335642            NA   1.0000000
    ## Churn_Score        -0.2249869      0.13375406            NA   0.6648970
    ## CLTV                0.3964057      0.09869321            NA  -0.1274631
    ##                 Churn_Score        CLTV
    ## Tenure_Months   -0.22498685  0.39640568
    ## Monthly_Charges  0.13375406  0.09869321
    ## Total_Charges            NA          NA
    ## Churn_Value      0.66489703 -0.12746310
    ## Churn_Score      1.00000000 -0.07978219
    ## CLTV            -0.07978219  1.00000000

``` r
# Compute measures of relationship for categorical variables (chi-square test)
for (var in categorical_vars) {
  cat(paste("Chi-square test for variable:", var, "\n"))
  cross_tab <- table(churn_data[[var]], churn_data$Churn_Label)
  chi_square_test <- chisq.test(cross_tab)
  print(chi_square_test)
  cat("\n")
}
```

    ## Chi-square test for variable: Count 
    ## 
    ##  Chi-squared test for given probabilities
    ## 
    ## data:  cross_tab
    ## X-squared = 1550.9, df = 1, p-value < 2.2e-16
    ## 
    ## 
    ## Chi-square test for variable: Country 
    ## 
    ##  Chi-squared test for given probabilities
    ## 
    ## data:  cross_tab
    ## X-squared = 1550.9, df = 1, p-value < 2.2e-16
    ## 
    ## 
    ## Chi-square test for variable: State 
    ## 
    ##  Chi-squared test for given probabilities
    ## 
    ## data:  cross_tab
    ## X-squared = 1550.9, df = 1, p-value < 2.2e-16
    ## 
    ## 
    ## Chi-square test for variable: City 
    ## 
    ##  Pearson's Chi-squared test
    ## 
    ## data:  cross_tab
    ## X-squared = 1233.6, df = 1128, p-value = 0.01498
    ## 
    ## 
    ## Chi-square test for variable: Zip_Code 
    ## 
    ##  Pearson's Chi-squared test
    ## 
    ## data:  cross_tab
    ## X-squared = 1746, df = 1651, p-value = 0.05118
    ## 
    ## 
    ## Chi-square test for variable: Gender 
    ## 
    ##  Pearson's Chi-squared test with Yates' continuity correction
    ## 
    ## data:  cross_tab
    ## X-squared = 0.48408, df = 1, p-value = 0.4866
    ## 
    ## 
    ## Chi-square test for variable: Senior_Citizen 
    ## 
    ##  Pearson's Chi-squared test with Yates' continuity correction
    ## 
    ## data:  cross_tab
    ## X-squared = 159.43, df = 1, p-value < 2.2e-16
    ## 
    ## 
    ## Chi-square test for variable: Partner 
    ## 
    ##  Pearson's Chi-squared test with Yates' continuity correction
    ## 
    ## data:  cross_tab
    ## X-squared = 158.73, df = 1, p-value < 2.2e-16
    ## 
    ## 
    ## Chi-square test for variable: Dependents 
    ## 
    ##  Pearson's Chi-squared test with Yates' continuity correction
    ## 
    ## data:  cross_tab
    ## X-squared = 433.73, df = 1, p-value < 2.2e-16
    ## 
    ## 
    ## Chi-square test for variable: Phone_Service 
    ## 
    ##  Pearson's Chi-squared test with Yates' continuity correction
    ## 
    ## data:  cross_tab
    ## X-squared = 0.91503, df = 1, p-value = 0.3388
    ## 
    ## 
    ## Chi-square test for variable: Multiple_Lines 
    ## 
    ##  Pearson's Chi-squared test
    ## 
    ## data:  cross_tab
    ## X-squared = 11.33, df = 2, p-value = 0.003464
    ## 
    ## 
    ## Chi-square test for variable: Internet_Service 
    ## 
    ##  Pearson's Chi-squared test
    ## 
    ## data:  cross_tab
    ## X-squared = 732.31, df = 2, p-value < 2.2e-16
    ## 
    ## 
    ## Chi-square test for variable: Online_Security 
    ## 
    ##  Pearson's Chi-squared test
    ## 
    ## data:  cross_tab
    ## X-squared = 850, df = 2, p-value < 2.2e-16
    ## 
    ## 
    ## Chi-square test for variable: Online_Backup 
    ## 
    ##  Pearson's Chi-squared test
    ## 
    ## data:  cross_tab
    ## X-squared = 601.81, df = 2, p-value < 2.2e-16
    ## 
    ## 
    ## Chi-square test for variable: Device_Protection 
    ## 
    ##  Pearson's Chi-squared test
    ## 
    ## data:  cross_tab
    ## X-squared = 558.42, df = 2, p-value < 2.2e-16
    ## 
    ## 
    ## Chi-square test for variable: Tech_Support 
    ## 
    ##  Pearson's Chi-squared test
    ## 
    ## data:  cross_tab
    ## X-squared = 828.2, df = 2, p-value < 2.2e-16
    ## 
    ## 
    ## Chi-square test for variable: Streaming_TV 
    ## 
    ##  Pearson's Chi-squared test
    ## 
    ## data:  cross_tab
    ## X-squared = 374.2, df = 2, p-value < 2.2e-16
    ## 
    ## 
    ## Chi-square test for variable: Streaming_Movies 
    ## 
    ##  Pearson's Chi-squared test
    ## 
    ## data:  cross_tab
    ## X-squared = 375.66, df = 2, p-value < 2.2e-16
    ## 
    ## 
    ## Chi-square test for variable: Contract 
    ## 
    ##  Pearson's Chi-squared test
    ## 
    ## data:  cross_tab
    ## X-squared = 1184.6, df = 2, p-value < 2.2e-16
    ## 
    ## 
    ## Chi-square test for variable: Paperless_Billing 
    ## 
    ##  Pearson's Chi-squared test with Yates' continuity correction
    ## 
    ## data:  cross_tab
    ## X-squared = 258.28, df = 1, p-value < 2.2e-16
    ## 
    ## 
    ## Chi-square test for variable: Payment_Method 
    ## 
    ##  Pearson's Chi-squared test
    ## 
    ## data:  cross_tab
    ## X-squared = 648.14, df = 3, p-value < 2.2e-16
    ## 
    ## 
    ## Chi-square test for variable: Churn_Label 
    ## 
    ##  Pearson's Chi-squared test with Yates' continuity correction
    ## 
    ## data:  cross_tab
    ## X-squared = 7037.9, df = 1, p-value < 2.2e-16
    ## 
    ## 
    ## Chi-square test for variable: Churn_Reason 
    ## 
    ##  Pearson's Chi-squared test
    ## 
    ## data:  cross_tab
    ## X-squared = 7043, df = 20, p-value < 2.2e-16

``` r
# ANOVA
# Define the categorical variable (factor)
categorical_var <- "Contract"  

# Define the numerical variable (response)
numerical_var <- "Monthly_Charges"  

# Perform ANOVA
anova_result <- aov(churn_data[[numerical_var]] ~ churn_data[[categorical_var]])

# Summarize ANOVA results
summary(anova_result)
```

    ##                                 Df  Sum Sq Mean Sq F value   Pr(>F)    
    ## churn_data[[categorical_var]]    2   37505   18752   20.83 9.58e-10 ***
    ## Residuals                     7040 6338399     900                     
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
