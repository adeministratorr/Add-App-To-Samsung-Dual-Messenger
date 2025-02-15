# Android App Cloner Script Documentation

## English 🇬🇧

### Description
This script automates the process of cloning Android applications using ADB (Android Debug Bridge). While some devices only support cloning for specific apps, this script allows you to clone any application using ADB commands.

### Prerequisites
- ADB (Android Debug Bridge) installed on your computer
  - Download from [Android Platform Tools](https://developer.android.com/tools/releases/platform-tools)
  - Or install via package manager:
    ```bash
    # macOS (using Homebrew)
    brew install android-platform-tools
    
    # Linux
    sudo apt-get install adb
    ```
- USB debugging enabled on your Android device
- Device connected to computer via USB

### Initial Setup
1. Enable Dual Messenger/Dual Apps:
   - Go to Settings > Advanced features > Dual Messenger
   - Enable the feature for the apps you want to clone

2. Enable USB Debugging:
   - Go to Settings > About phone
   - Tap "Build number" 7 times to enable Developer options
   - Go back to Settings > Developer options
   - Enable "USB debugging"
   - Disable "Automatic system updates"

### Configuration
1. Find your device's dual app user ID:
   ```bash
   adb shell pm list users
   ```
   Look for "DUAL_APP" in the output:
   ```plaintext
   UserInfo{95:DUAL_APP:20000030} running
   ```

2. Edit the script to customize:
   - USER_ID: The user ID for cloned apps (default: 95)
   - PACKAGES: List of package names to clone
   ```bash
   PACKAGES=(
       "com.example.app1"
       "com.example.app2"
   )
   ```

### Usage
1. Clone or download this repository
2. Make the script executable: `chmod +x clone.sh`
3. Run the script: `./clone.sh`

### How It Works
1. The script pulls APKs from your device for specified packages
2. Creates a directory structure for organized storage
3. Handles both single APK and split APK installations
4. Installs the apps for a specific user profile (default: 95 - typically the dual app profile)

### Output Structure
```plaintext
pulled_apks/
├── com.example.app1/
│   ├── base.apk
│   ├── split_config.arm64_v8a.apk
│   └── split_config.xxhdpi.apk
└── com.example.app2/
    └── base.apk
```

### Troubleshooting
1. If installation fails:
   - Ensure USB debugging is enabled
   - Check if the device is properly connected
   - Verify the package name is correct
   - Make sure you have sufficient storage space

2. If APK pulling fails:
   - Confirm the app is installed on your device
   - Check if you have the necessary permissions

### Post-Usage Security
1. Disable USB Debugging:
   - Go to Settings > Developer options
   - Disable "USB debugging"
   - Re-enable "Automatic system updates"
2. You can keep Dual Messenger enabled for your cloned apps to continue using them

---

## Türkçe 🇹🇷

### Açıklama
Bu script, ADB (Android Debug Bridge) kullanarak Android uygulamalarını klonlama işlemini otomatikleştirir. Bazı cihazlar yalnızca belirli uygulamalar için klonlamayı desteklerken, bu script ADB komutlarını kullanarak herhangi bir uygulamayı klonlamanıza olanak tanır.

### Gereksinimler
- Bilgisayarınızda ADB (Android Debug Bridge) yüklü olmalı
- Android cihazınızda USB hata ayıklama etkin olmalı
- Cihaz USB ile bilgisayara bağlı olmalı

### Başlangıç Ayarları
1. Çift Messenger/Çift Uygulama özelliğini etkinleştirme:
   - Ayarlar > Gelişmiş özellikler > Çift Messenger'a gidin
   - Klonlamak istediğiniz uygulamalar için özelliği etkinleştirin

2. USB Hata Ayıklamayı Etkinleştirme:
   - Ayarlar > Telefon hakkında'ya gidin
   - Geliştirici seçeneklerini etkinleştirmek için "Yapı numarası"na 7 kez dokunun
   - Ayarlar > Geliştirici seçenekleri'ne geri dönün
   - "USB hata ayıklama"yı etkinleştirin
   - "Otomatik sistem güncellemeleri"ni devre dışı bırakın

### Kullanım
1. Bu depoyu klonlayın veya indirin
2. Scripti çalıştırılabilir yapın: `chmod +x clone.sh`
3. Scripti çalıştırın: `./clone.sh`

### Nasıl Çalışır
1. Script, belirtilen paketler için cihazınızdan APK'ları çeker
2. Düzenli depolama için bir dizin yapısı oluşturur
3. Hem tekli APK hem de split APK kurulumlarını yönetir
4. Uygulamaları belirli bir kullanıcı profili için kurar (varsayılan: 95 - genellikle çift uygulama profili)

### Kullanım Sonrası Güvenlik
1. USB Hata Ayıklamayı Devre Dışı Bırakma:
   - Ayarlar > Geliştirici seçenekleri'ne gidin
   - "USB hata ayıklama"yı devre dışı bırakın
   - "Otomatik sistem güncellemeleri"ni yeniden etkinleştirin
2. Klonlanmış uygulamalarınızı kullanmaya devam etmek için Çift Messenger'ı etkin tutabilirsiniz

---

## 中文 🇨🇳

### 描述
此脚本使用 ADB（Android Debug Bridge）自动化克隆 Android 应用程序的过程。虽然某些设备仅支持特定应用程序的克隆，但此脚本允许您使用 ADB 命令克隆任何应用程序。

### 前提条件
- 计算机上安装了 ADB（Android Debug Bridge）
- Android 设备上启用了 USB 调试
- 设备通过 USB 连接到计算机

### 使用方法
1. 克隆或下载此存储库
2. 编辑 `clone.sh` 脚本，在 `PACKAGES` 数组中添加所需的包名
3. 使脚本可执行：`chmod +x clone.sh`
4. 运行脚本：`./clone.sh`

### 工作原理
1. 脚本从设备中提取指定包的 APK
2. 创建目录结构以进行有组织的存储
3. 处理单个 APK 和分割 APK 安装
4. 为特定用户配置文件安装应用程序（默认值：95 - 通常是双应用配置文件）

---

## العربية 🇸🇦

### الوصف
يقوم هذا السكريبت بأتمتة عملية استنساخ تطبيقات Android باستخدام ADB (Android Debug Bridge). بينما تدعم بعض الأجهزة الاستنساخ لتطبيقات محددة فقط، يتيح لك هذا السكريبت استنساخ أي تطبيق باستخدام أوامر ADB.

### المتطلبات الأساسية
- تثبيت ADB (Android Debug Bridge) على جهاز الكمبيوتر الخاص بك
- تمكين تصحيح USB على جهاز Android الخاص بك
- توصيل الجهاز بالكمبيوتر عبر USB

### طريقة الاستخدام
1. استنسخ أو قم بتنزيل هذا المستودع
2. قم بتحرير السكريبت `clone.sh` لإضافة أسماء الحزم المطلوبة في مصفوفة `PACKAGES`
3. اجعل السكريبت قابل للتنفيذ: `chmod +x clone.sh`
4. قم بتشغيل السكريبت: `./clone.sh`

### كيف يعمل
1. يقوم السكريبت بسحب ملفات APK من جهازك للحزم المحددة
2. ينشئ هيكل دليل للتخزين المنظم
3. يتعامل مع تثبيتات APK الفردية والمقسمة
4. يثبت التطبيقات لملف تعريف مستخدم محدد (الافتراضي: 95 - عادةً ملف تعريف التطبيق المزدوج)