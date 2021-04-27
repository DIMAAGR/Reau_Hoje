import 'package:reau_hoje/data/data.dart';

/// ESTA CLASSE DEFINE A LINGUA DO APLICATIVO!
/// DE ACORDO COM A LINGUA DEFINIDA PELO USUÁRIO SERA UTILIZADA NELA
class Language {
  String _language = MyPreferences.getLanguage();
  Map<String, String> _selectedLanguage;

  void setLanguage({String language}) => _language = language;
  Map<String, String> getSelectedLanguageInfo() => _selectedLanguage;
  String getLanguage() => _language;

  Language() {
    defLanguage();
  }

  /* SUPORTED LANGUAGES
   * Español
   * English
   * Português
   * Français
   * 中文
   * 日本語
   * 
   */

  /// [defLanguage] define o tipo de linguagem que será utilizada no App.
  /// verifica qual foi selecionada a partir do [Language] e utiliza o switch para
  /// determina-la.
  defLanguage() {
    switch (_language) {
      case "EN":
        enlang();
        break;
      case "PT-BR":
        ptbrLang();
        break;
      case "ES":
        spanishLang();
        break;
      case "FR":
        franceLang();
        break;
      case "JP":
        japanLang();
        break;
      case "CN":
        chineseLang();
        break;
      case "RU":
        russkiyLang();
        break;
      case "TR":
        turkLang();
        break;
      case "AR":
        eurbaaLang();
        break;
    }
  }

  /// Caso a linguagem selecionada seja Inglês
  void enlang() {
    _selectedLanguage = {
      "ID": "1",
      "Hello": "Hello,",
      "MyWallet": "My Wallet",
      "MyReaus": "My Reaus",
      "Calculator": "Calculator",
      "Settings": "Settings",
      "Transfer": "Transfer",
      "Analysis": "Analises",
      "MarketCap": "Market Capital",
      "AllRightReserved": "All Right Reserved",
      "Donatenow": "Donate Now",
      "TotalWalletValue": "Total value of your Wallet:",
      "HeloWeStillHaveNotMet": "Helo! We still have not met!",
      "WhatIsYourName": "What is your name?",
      "IStillDontKnowYourWallet": "i still don't know your wallet!",
      "PleaseInsertYourWallet": "Please insert your wallet!",
      "IsThisYourWallet?": "Is this your wallet?",
      "Language": "English",
      "Currency": "",
      "MyProfile": "My Profile",
    };
  }

  /// Caso a linguagem selecionada seja PT-BR
  void ptbrLang() {
    _selectedLanguage = {
      "ID": "2",
      "Hello": "Olá,",
      "MyWallet": "Minha Carteira",
      "MyReaus": "Meus Reaus",
      "Calculator": "Calculadora",
      "Settings": "Configurações",
      "Transfer": "Transferências",
      "Analysis": "Analises",
      "MarketCap": "Capital de Mercado",
      "AllRightReserved": "Todos os Direitos Reservados",
      "Donatenow": "Doe Agora",
      "TotalWalletValue": "Valor total da Carteira:",
      "HeloWeStillHaveNotMet": "Olá! Ainda não nos Conhecemos!",
      "WhatIsYourName": "Qual é o seu nome?",
      "IStillDontKnowYourWallet": "eu ainda não sei sua carteira!",
      "PleaseInsertYourWallet": "Por favor insira sua carteira!",
      "IsThisYourWallet?": "Esta é sua Carteira?",
      "Language": "Português",
      "Currency": "",
      "MyProfile": "Meu Perfil",
    };
  }

  /// Caso a linguagem selecionada seja FR
  void franceLang() {
    _selectedLanguage = {
      "ID": "3",
      "Hello": "Bonjour,",
      "MyWallet": "Mon portefeuille",
      "MyReaus": "My Reaus",
      "Calculator": "Calculatrice",
      "Settings": "Paramètres",
      "Transfer": "Transferts",
      "Analysis": "Analyses",
      "MarketCap": "Market Capital",
      "AllRightReserved": "Tous droits réservés",
      "Donatenow": "Faire un don maintenant",
      "TotalWalletValue": "Montant total du portefeuille:",
      "HeloWeStillHaveNotMet":
          "Helo! Nous ne nous sommes toujours pas rencontrés!",
      "WhatIsYourName": "Quel est ton nom?",
      "IStillDontKnowYourWallet":
          "je ne connais toujours pas votre portefeuille!",
      "PleaseInsertYourWallet": "Veuillez insérer votre portefeuille!",
      "IsThisYourWallet?": "Est-ce votre portefeuille?",
      "Language": "français",
      "Currency": "",
      "MyProfile": "Mon profil",
    };
  }

  /// Caso a linguagem selecionada seja ES
  void spanishLang() {
    _selectedLanguage = {
      "ID": "4",
      "Hello": "Hola,",
      "MyWallet": "Mi Cartera",
      "MyReaus": "Mi Reaus",
      "Calculator": "Calculadora",
      "Settings": "Configuración",
      "Transfer": "Transferencias",
      "Analysis": "Análisis",
      "MarketCap": "Capital de mercado",
      "AllRightReserved": "Todos los derechos reservados",
      "Donatenow": "Done ahora",
      "TotalWalletValue": "Importe total de la cartera:",
      "HeloWeStillHaveNotMet": "¡Hola! ¡Todavía no nos hemos conocido!",
      "WhatIsYourName": "¿Cual es tu nombre?",
      "IStillDontKnowYourWallet": "¡Todavía no conozco tu billetera!",
      "PleaseInsertYourWallet": "¡Por favor inserte su billetera!",
      "IsThisYourWallet?": "¿Esta es tu cartera?",
      "Language": "Español",
      "Currency": "",
      "MyProfile": "Mi perfil",
    };
  }

  /// Caso a linguagem selecionada seja JAPANESE
  void japanLang() {
    _selectedLanguage = {
      "ID": "5",
      "Hello": "こんにちは",
      "MyWallet": "私の財布",
      "MyReaus": "私の Reaus",
      "Calculator": "電卓",
      "Settings": "設定",
      "Transfer": "転送",
      "Analysis": "分析",
      "MarketCap": "時価総額",
      "AllRightReserved": "全著作権所有",
      "Donatenow": "さあ寄付しよう",
      "TotalWalletValue": "ポートフォリオの総価値：",
      "HeloWeStillHaveNotMet": "こんにちは！ まだ会っていません！",
      "WhatIsYourName": "お名前は何ですか？",
      "IStillDontKnowYourWallet": "私はまだあなたの財布を知りません！",
      "PleaseInsertYourWallet": "財布を入れてください！",
      "IsThisYourWallet?": "これはあなたの財布ですか？",
      "Language": "日本語",
      "Currency": "",
      "MyProfile": "私のプロフィール",
    };
  }

  /// Caso a linguagem selecionada seja Chinese
  void chineseLang() {
    _selectedLanguage = {
      "ID": "6",
      "Hello": "你好，",
      "MyWallet": "我的钱包",
      "MyReaus": "我的Reaus",
      "Calculator": "计算器",
      "Settings": "设定",
      "Transfer": "转账",
      "Analysis": "分析",
      "MarketCap": "市场资本",
      "AllRightReserved": "版权所有",
      "Donatenow": "立即捐款",
      "TotalWalletValue": "投资组合总值：",
      "HeloWeStillHaveNotMet": "喂！ 我们还没有见面！",
      "WhatIsYourName": "你叫什么名字？",
      "IStillDontKnowYourWallet": "我还是不知道你的钱包！",
      "PleaseInsertYourWallet": "请插入您的钱包！",
      "IsThisYourWallet?": "这是你的钱包吗？",
      "Language": "中文",
      "Currency": "",
      "MyProfile": "我的簡歷",
    };
  }

  void russkiyLang() {
    _selectedLanguage = {
      "ID": "7",
      "Hello": "Привет,",
      "MyWallet": "Мой бумажник",
      "MyReaus": "Мой Реаус",
      "Calculator": "Калькулятор",
      "Settings": "настройки",
      "Transfer": "Переводы",
      "Analysis": "Анализ",
      "MarketCap": "Рыночный капитал",
      "AllRightReserved": "Все права защищены",
      "Donatenow": "Пожертвовать сейчас",
      "TotalWalletValue": "Общая стоимость портфеля:",
      "HeloWeStillHaveNotMet": "Привет! Мы до сих пор не встречались!",
      "WhatIsYourName": "Как тебя зовут?",
      "IStillDontKnowYourWallet": "я все еще не знаю твой кошелек!",
      "PleaseInsertYourWallet": "Пожалуйста, вставьте свой кошелек!",
      "IsThisYourWallet?": "Это твой кошелек?",
      "Language": "русский язык",
      "Currency": "",
      "MyProfile": "Мой профиль",
    };
  }

  void turkLang() {
    _selectedLanguage = {
      "ID": "8",
      "Hello": "Selam,",
      "MyWallet": "Cüzdanım",
      "MyReaus": "Benim Reausum",
      "Calculator": "Hesap makinesi",
      "Settings": "ayarlar",
      "Transfer": "Transferler",
      "Analysis": "analiz",
      "MarketCap": "Piyasa Sermayesi",
      "AllRightReserved": "Tüm hakları Saklıdır",
      "Donatenow": "Şimdi Bağış yap",
      "TotalWalletValue": "Toplam Portföy Değeri:",
      "HeloWeStillHaveNotMet": "Merhaba Henüz tanışmadık!",
      "WhatIsYourName": "Adın ne?",
      "IStillDontKnowYourWallet": "hala cüzdanını bilmiyorum!",
      "PleaseInsertYourWallet": "Lütfen cüzdanınızı takın!",
      "IsThisYourWallet?": "Bu senin cüzdanın mı?",
      "Language": "Türk Dili",
      "Currency": "",
      "MyProfile": "Benim profilim",
    };
  }

  void eurbaaLang() {
    _selectedLanguage = {
      "ID": "9",
      "Hello": "مرحبا،",
      "MyWallet": "محفظتى",
      "MyReaus": "لي Reau",
      "Calculator": "آلة حاسبة",
      "Settings": "الإعدادات",
      "Transfer": "التحويلات",
      "Analysis": "التحليلات",
      "MarketCap": "رأس المال السوقي",
      "AllRightReserved": "كل الحقوق محفوظة",
      "Donatenow": "التبرع",
      "TotalWalletValue": "إجمالي قيمة المحفظة:",
      "HeloWeStillHaveNotMet": "مرحبا لم نلتقي بعد!",
      "WhatIsYourName": "ما اسمك؟",
      "IStillDontKnowYourWallet": "ما زلت لا أعرف محفظتك!",
      "PleaseInsertYourWallet": "الرجاء إدخال محفظتك!",
      "IsThisYourWallet?": "هل هذه محفظتك؟",
      "Language": "عربى",
      "Currency": "",
      "MyProfile": "ملفي",
    };
  }
}
