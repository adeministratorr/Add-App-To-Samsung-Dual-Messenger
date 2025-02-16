# Android App Cloner Script Documentation

## English 🇬🇧

### Description
This script automates the process of cloning Android applications using ADB (Android Debug Bridge). While some devices only support cloning for specific apps, this script allows you to clone any application using ADB commands.

### Prerequisites
- ADB (Android Debug Bridge) installed on your computer
  - Download from [Android Platform Tools](https://developer.android.com/tools/releases/platform-tools)
  - Installation methods by operating system:
    
    #### Windows
    1. Using Chocolatey package manager:
    ```bash
    choco install adb
    ```
    2. Manual installation:
    - Download the [Android SDK Platform Tools](https://developer.android.com/tools/releases/platform-tools) ZIP file
    - Extract to a location (e.g., `C:\android-platform-tools`)
    - Add to System Environment Variables:
      - Open System Properties > Advanced > Environment Variables
      - Add the extraction path to the PATH variable
    - Verify installation: `adb --version`

    #### macOS
    1. Using Homebrew:
    ```bash
    brew install android-platform-tools
    ```
    2. Manual installation:
    - Download the [Android SDK Platform Tools](https://developer.android.com/tools/releases/platform-tools) ZIP file
    - Extract to a location (e.g., `~/android-platform-tools`)
    - Add to PATH in `~/.zshrc` or `~/.bash_profile`:
    ```bash
    export PATH="$PATH:~/android-platform-tools"
    ```
    - Reload shell configuration: `source ~/.zshrc` or `source ~/.bash_profile`
    - Verify installation: `adb --version`

    #### Linux
    1. Using package manager:
    ```bash
    # Debian/Ubuntu
    sudo apt-get update
    sudo apt-get install adb

    # Fedora
    sudo dnf install android-tools

    # Arch Linux
    sudo pacman -S android-tools
    ```
    2. Manual installation:
    - Download the [Android SDK Platform Tools](https://developer.android.com/tools/releases/platform-tools) ZIP file
    - Extract to a location (e.g., `/opt/android-platform-tools`)
    - Add to PATH in `~/.bashrc` or `~/.zshrc`:
    ```bash
    export PATH="$PATH:/opt/android-platform-tools"
    ```
    - Reload shell configuration: `source ~/.bashrc` or `source ~/.zshrc`
    - Verify installation: `adb --version`

    #### Troubleshooting
    - If `adb` command is not found: Verify PATH configuration and shell reload
    - Permission issues on Linux: Add user to `plugdev` group: `sudo usermod -aG plugdev $USER`
    - Device not detected: Install USB drivers (Windows) or add udev rules (Linux)

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
  - [Android Platform Tools](https://developer.android.com/tools/releases/platform-tools) adresinden indirin
  - İşletim sistemine göre kurulum yöntemleri:
    
    #### Windows
    1. Chocolatey paket yöneticisi kullanarak:
    ```bash
    choco install adb
    ```
    2. Manuel kurulum:
    - [Android SDK Platform Tools](https://developer.android.com/tools/releases/platform-tools) ZIP dosyasını indirin
    - Bir konuma çıkartın (örn. `C:\android-platform-tools`)
    - Sistem Ortam Değişkenlerine ekleyin:
      - Sistem Özellikleri > Gelişmiş > Ortam Değişkenleri'ni açın
      - Çıkartılan yolu PATH değişkenine ekleyin
    - Kurulumu doğrulayın: `adb --version`

    #### macOS
    1. Homebrew kullanarak:
    ```bash
    brew install android-platform-tools
    ```
    2. Manuel kurulum:
    - [Android SDK Platform Tools](https://developer.android.com/tools/releases/platform-tools) ZIP dosyasını indirin
    - Bir konuma çıkartın (örn. `~/android-platform-tools`)
    - PATH'e ekleyin (`~/.zshrc` veya `~/.bash_profile` içinde):
    ```bash
    export PATH="$PATH:~/android-platform-tools"
    ```
    - Kabuk yapılandırmasını yeniden yükleyin: `source ~/.zshrc` veya `source ~/.bash_profile`
    - Kurulumu doğrulayın: `adb --version`

    #### Linux
    1. Paket yöneticisi kullanarak:
    ```bash
    # Debian/Ubuntu
    sudo apt-get update
    sudo apt-get install adb

    # Fedora
    sudo dnf install android-tools

    # Arch Linux
    sudo pacman -S android-tools
    ```
    2. Manuel kurulum:
    - [Android SDK Platform Tools](https://developer.android.com/tools/releases/platform-tools) ZIP dosyasını indirin
    - Bir konuma çıkartın (örn. `/opt/android-platform-tools`)
    - PATH'e ekleyin (`~/.bashrc` veya `~/.zshrc` içinde):
    ```bash
    export PATH="$PATH:/opt/android-platform-tools"
    ```
    - Kabuk yapılandırmasını yeniden yükleyin: `source ~/.bashrc` veya `source ~/.zshrc`
    - Kurulumu doğrulayın: `adb --version`

    #### Sorun Giderme
    - Eğer `adb` komutu bulunamazsa: PATH yapılandırmasını ve kabuk yeniden yüklemeyi doğrulayın
    - Linux'ta izin sorunları: Kullanıcıyı `plugdev` grubuna ekleyin: `sudo usermod -aG plugdev $USER`
    - Cihaz algılanmıyorsa: USB sürücülerini (Windows) veya udev kurallarını (Linux) yükleyin

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
  - 从 [Android Platform Tools](https://developer.android.com/tools/releases/platform-tools) 下载
  - 根据操作系统的安装方法：
    
    #### Windows
    1. 使用 Chocolatey 包管理器：
    ```bash
    choco install adb
    ```
    2. 手动安装：
    - 下载 [Android SDK Platform Tools](https://developer.android.com/tools/releases/platform-tools) ZIP 文件
    - 解压到指定位置（例如：`C:\android-platform-tools`）
    - 添加到系统环境变量：
      - 打开系统属性 > 高级 > 环境变量
      - 将解压路径添加到 PATH 变量
    - 验证安装：`adb --version`

    #### macOS
    1. 使用 Homebrew：
    ```bash
    brew install android-platform-tools
    ```
    2. 手动安装：
    - 下载 [Android SDK Platform Tools](https://developer.android.com/tools/releases/platform-tools) ZIP 文件
    - 解压到指定位置（例如：`~/android-platform-tools`）
    - 添加到 PATH（在 `~/.zshrc` 或 `~/.bash_profile` 中）：
    ```bash
    export PATH="$PATH:~/android-platform-tools"
    ```
    - 重新加载 shell 配置：`source ~/.zshrc` 或 `source ~/.bash_profile`
    - 验证安装：`adb --version`

    #### Linux
    1. 使用包管理器：
    ```bash
    # Debian/Ubuntu
    sudo apt-get update
    sudo apt-get install adb

    # Fedora
    sudo dnf install android-tools

    # Arch Linux
    sudo pacman -S android-tools
    ```
    2. 手动安装：
    - 下载 [Android SDK Platform Tools](https://developer.android.com/tools/releases/platform-tools) ZIP 文件
    - 解压到指定位置（例如：`/opt/android-platform-tools`）
    - 添加到 PATH（在 `~/.bashrc` 或 `~/.zshrc` 中）：
    ```bash
    export PATH="$PATH:/opt/android-platform-tools"
    ```
    - 重新加载 shell 配置：`source ~/.bashrc` 或 `source ~/.zshrc`
    - 验证安装：`adb --version`

    #### 故障排除
    - 如果找不到 `adb` 命令：验证 PATH 配置和 shell 重新加载
    - Linux 上的权限问题：将用户添加到 `plugdev` 组：`sudo usermod -aG plugdev $USER`
    - 设备未检测到：安装 USB 驱动程序（Windows）或添加 udev 规则（Linux）

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
  - قم بالتحميل من [Android Platform Tools](https://developer.android.com/tools/releases/platform-tools)
  - طرق التثبيت حسب نظام التشغيل:
    
    #### Windows
    1. باستخدام مدير الحزم Chocolatey:
    ```bash
    choco install adb
    ```
    2. التثبيت اليدوي:
    - قم بتحميل ملف [Android SDK Platform Tools](https://developer.android.com/tools/releases/platform-tools) ZIP
    - قم بفك الضغط إلى موقع (مثال: `C:\android-platform-tools`)
    - أضف إلى متغيرات النظام البيئية:
      - افتح خصائص النظام > متقدم > متغيرات البيئة
      - أضف مسار الاستخراج إلى متغير PATH
    - تحقق من التثبيت: `adb --version`

    #### macOS
    1. باستخدام Homebrew:
    ```bash
    brew install android-platform-tools
    ```
    2. التثبيت اليدوي:
    - قم بتحميل ملف [Android SDK Platform Tools](https://developer.android.com/tools/releases/platform-tools) ZIP
    - قم بفك الضغط إلى موقع (مثال: `~/android-platform-tools`)
    - أضف إلى PATH (في `~/.zshrc` أو `~/.bash_profile`):
    ```bash
    export PATH="$PATH:~/android-platform-tools"
    ```
    - أعد تحميل إعدادات shell: `source ~/.zshrc` أو `source ~/.bash_profile`
    - تحقق من التثبيت: `adb --version`

    #### Linux
    1. باستخدام مدير الحزم:
    ```bash
    # Debian/Ubuntu
    sudo apt-get update
    sudo apt-get install adb

    # Fedora
    sudo dnf install android-tools

    # Arch Linux
    sudo pacman -S android-tools
    ```
    2. التثبيت اليدوي:
    - قم بتحميل ملف [Android SDK Platform Tools](https://developer.android.com/tools/releases/platform-tools) ZIP
    - قم بفك الضغط إلى موقع (مثال: `/opt/android-platform-tools`)
    - أضف إلى PATH (في `~/.bashrc` أو `~/.zshrc`):
    ```bash
    export PATH="$PATH:/opt/android-platform-tools"
    ```
    - أعد تحميل إعدادات shell: `source ~/.bashrc` أو `source ~/.zshrc`
    - تحقق من التثبيت: `adb --version`

    #### استكشاف الأخطاء وإصلاحها
    - إذا لم يتم العثور على أمر `adb`: تحقق من تكوين PATH وإعادة تحميل shell
    - مشاكل الصلاحيات على Linux: أضف المستخدم إلى مجموعة `plugdev`: `sudo usermod -aG plugdev $USER`
    - لم يتم اكتشاف الجهاز: قم بتثبيت برامج تشغيل USB (Windows) أو أضف قواعد udev (Linux)

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
