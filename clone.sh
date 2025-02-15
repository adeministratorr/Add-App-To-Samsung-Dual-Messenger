#!/bin/bash

# Variables / Değişkenler / 变量 / المتغيرات
# User ID for dual apps profile
# İkili uygulama profili için kullanıcı kimliği
# 双应用配置文件的用户 ID
# معرف المستخدم لملف تعريف التطبيق المزدوج
USER_ID="95"
# Package list - add your desired packages here
# Paket listesi - istediğiniz paketleri buraya ekleyin
# 软件包列表 - 在此处添加所需的包
# قائمة الحزم - أضف الحزم المطلوبة هنا
PACKAGES=(
    "com.binance.dev"
    "com.ykb.android" #doesn't work after clonings
    "com.cloud.tr"
    "com.twitter.android"
    # Add more packages... / Diğer paketler... / 添加更多包... / أضف المزيد من الحزم...
)

# Working directory for APK files
# APK dosyaları için çalışma dizini
# APK 文件的工作目录
# دليل العمل لملفات APK
WORK_DIR="pulled_apks"
mkdir -p "$WORK_DIR"

for PACKAGE in "${PACKAGES[@]}"; do
    echo "Processing package: $PACKAGE"
    
    # Create directory for each package
    # Her paket için klasör oluştur
    # 为每个包创建目录
    # إنشاء دليل لكل حزمة
    PKG_DIR="${WORK_DIR}/${PACKAGE}"
    mkdir -p "$PKG_DIR"
    
    echo "1. Pulling APKs for ${PACKAGE}..."
    # Extract APKs from device
    # APK'ları cihazdan çek
    # 从设备提取 APK
    # استخراج ملفات APK من الجهاز
    adb shell pm path $PACKAGE | sed 's/package://' | while read -r line; do
        clean_name=$(echo "$line" | sed -E "s/.*${PACKAGE}-[^/]+\///")
        echo "Pulling: $line to ${PKG_DIR}/${clean_name}"
        adb pull "$line" "${PKG_DIR}/${clean_name}"
    done
    
    echo -e "\n2. Installing APKs for ${PACKAGE} (user ${USER_ID})..."
    cd "${PKG_DIR}"
    
    # Check for base.apk and split APKs
    # Base.apk ve split APK'ları kontrol et
    # 检查 base.apk 和分割 APK
    # التحقق من base.apk وملفات APK المقسمة
    if [ -f "base.apk" ]; then
        echo "Installing APKs..."
    
        # Add all APKs to array for single installation command
        # Tüm APK'ları tek komutta yüklemek için diziye ekle
        # 将所有 APK 添加到数组中以进行单次安装
        # إضافة جميع ملفات APK إلى المصفوفة للتثبيت بأمر واحد
        apk_files=("base.apk")
    
        # Add split APKs if they exist
        # Split APK'ları varsa diziye ekle
        # 如果存在分割 APK，则添加它们
        # إضافة ملفات APK المقسمة إذا وجدت
        for split in split_*.apk; do
        if [ -f "$split" ]; then
            apk_files+=("$split")
        fi
    done
    
    # Tüm APK'ları tek seferde yükle
    echo "Installing ${#apk_files[@]} APK files..."
    adb install-multiple --user $USER_ID -r -d "${apk_files[@]}"
    echo "✅ Installation completed for ${PACKAGE}"
else
    echo "❌ base.apk not found for ${PACKAGE}"
fi

    
    cd ../../
    echo -e "------------------------\n"
done

echo "All packages processed!"
echo "Installed packages for user ${USER_ID}:"
adb shell pm list packages --user $USER_ID