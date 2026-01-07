#!/bin/bash
# Clash 配置文件批量替换脚本
# 用途：将 Clash 配置中的 zhanyeye 替换为 OceanEyeFF
# 作者：浮浮酱 ฅ'ω'ฅ

set -e

echo "🔍 Clash 配置文件批量替换工具"
echo "================================"
echo ""

# 配置文件路径
CONFIG_FILE="$1"

if [ -z "$CONFIG_FILE" ]; then
    echo "❌ 错误：请提供配置文件路径"
    echo ""
    echo "用法："
    echo "  bash update-clash-config.sh <配置文件路径>"
    echo ""
    echo "示例："
    echo "  bash update-clash-config.sh ~/clash-config.yaml"
    exit 1
fi

if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ 错误：文件不存在: $CONFIG_FILE"
    exit 1
fi

# 备份原文件
BACKUP_FILE="${CONFIG_FILE}.backup-$(date +%Y%m%d-%H%M%S)"
echo "📦 创建备份: $BACKUP_FILE"
cp "$CONFIG_FILE" "$BACKUP_FILE"

# 执行替换
echo "🔄 替换 zhanyeye → OceanEyeFF..."
sed -i 's/zhanyeye/OceanEyeFF/g' "$CONFIG_FILE"

# 检查替换结果
REPLACED_COUNT=$(grep -c "OceanEyeFF" "$CONFIG_FILE" || true)
echo "✅ 完成！共替换 $REPLACED_COUNT 处"

echo ""
echo "📝 替换后的 rule-providers 配置："
grep -A 10 "rule-providers:" "$CONFIG_FILE" | head -20 || true

echo ""
echo "💡 提示："
echo "  1. 备份文件已保存到: $BACKUP_FILE"
echo "  2. 在 Clash 中刷新规则集并重启"
echo "  3. 如需恢复，运行: cp $BACKUP_FILE $CONFIG_FILE"
