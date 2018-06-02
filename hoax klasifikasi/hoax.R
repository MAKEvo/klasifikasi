library(caret)
library(tm)
library(SnowballC)
library(arm)
# Training data.
data <- c('Bom mapolres surabaya adalah pengalihan isu.',
          'Produsen rokok Marlboro mengeluarkan produk rokok  ganja.',
          'Peneliti Rusia Temukan Cara Mengubah Orang Negro Menjadi Putih.',
          'Presiden Joko Widodo Bermain Game Clash of Clans.',
          'Serbuan Tenaga Kerja China ke Indonesia.',
          'pengubahan air menjadi bensin.',
          'selamat anda mendapatkan uang 100 juta.',
          'Dosen Gaib Di Yogyakarta.',
          'manusia bertelur.',
          'penampakan ufo di blok m.',
          'Peledakan bom mapolres surabaya menelan 5 korban jiwa.',
          'semarang ibukota jawa tengah.',
          'zinedine zidane berhenti melatih real madrid.',
          'warga negara indonesia dilarang mengunjungi jerusalem.',
          'gunung merapi terjadi erupsi.',
          'Warga Lereng Merapi Masih Bertahan di Pengungsian.',
          'terminal baru bandara achamd yani semarang rampung.',
          'mohamed salah pemain timnas mesir absen karena mengalami cidera.',
          'bandung ibukota jawa barat.',
          'surabaya ibukota jawatimur.')
corpus <- VCorpus(VectorSource(data))

# Create a document term matrix.
tdm <- DocumentTermMatrix(corpus, list(removePunctuation = TRUE, stopwords = TRUE, stemming = TRUE, removeNumbers = TRUE))

# Convert to a data.frame for training and assign a classification (factor) to each document.
train <- as.matrix(tdm)
train <- cbind(train, c(0, 1))
colnames(train)[ncol(train)] <- 'y'
train <- as.data.frame(train)
train$y <- as.factor(train$y)
data
train
# Train.
fit <- train(y ~ ., data = train, method = 'bayesglm')

# Check accuracy on training.
predict(fit, newdata = train)

# Test data.
data2 <- c('Jatuh korban jiwa dalam ledakan bom di mapolres surabaya.',
           'bandara achmad yani batal beroperasi',
           'ibukota jawa tengah adalah semarang.',
           'gunung merapi beraktivitas aman',
           'terjadi serbuan tenaga asing ke indonesia.',
           'Zidane tidak Lagi Melatih Real.',
           'Abu Vulkanik Menutupi Jogja.',
           'Megawati Sesak Napas Sering dibully Netizen.',
           'Zlatan akan tetap Bermain di LA Galaxy.',
           'manusia beranak dengan cara melahirkan.')
corpus <- VCorpus(VectorSource(data2))
tdm <- DocumentTermMatrix(corpus, control = list(dictionary = Terms(tdm), removePunctuation = TRUE, stopwords = TRUE, stemming = TRUE, removeNumbers = TRUE))
test <- as.matrix(tdm)

# Check accuracy on test.
predict(fit, newdata = test)
