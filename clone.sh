#!/bin/bash

# Değişkenler
USER_ID="95"
# Paket listesi - istediğiniz paketleri buraya ekleyin
PACKAGES=(
    "com.binance.dev"
    "com.ykb.android"
    "com.cloud.tr"
    "com.twitter.android"
    # Diğer paketler...
)

WORK_DIR="pulled_apks"
mkdir -p "$WORK_DIR"

for PACKAGE in "${PACKAGES[@]}"; do
    echo "Processing package: $PACKAGE"
    
    # Her paket için klasör oluştur
    PKG_DIR="${WORK_DIR}/${PACKAGE}"
    mkdir -p "$PKG_DIR"
    
    echo "1. Pulling APKs for ${PACKAGE}..."
    # APK'ları çek
    adb shell pm path $PACKAGE | sed 's/package://' | while read -r line; do
        clean_name=$(echo "$line" | sed -E "s/.*${PACKAGE}-[^/]+\///")
        echo "Pulling: $line to ${PKG_DIR}/${clean_name}"
        adb pull "$line" "${PKG_DIR}/${clean_name}"
    done
    
    echo -e "\n2. Installing APKs for ${PACKAGE} (user ${USER_ID})..."
    cd "${PKG_DIR}"
    
  # Önce base.apk'yı bul ve split APK'ları kontrol et
if [ -f "base.apk" ]; then
    echo "Installing APKs..."
    
    # Tüm APK'ları tek komutta yüklemek için diziye ekle
    apk_files=("base.apk")
    
    # Split APK'ları varsa diziye ekle
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
