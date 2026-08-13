# VivaTalk — بناء APK

هذا المشروع يحتوي على واجهة MVP لتطبيق VivaTalk.

## بناء التطبيق

من بيئة Flutter:

```bash
flutter pub get
flutter build apk --release
```

سيظهر APK عادةً في:
`build/app/outputs/flutter-apk/app-release.apk`

## ملاحظة
النسخة الحالية هي MVP للواجهة. اللايف الحقيقي، الدردشة الصوتية الحية، الحسابات، قاعدة البيانات، الإشعارات والهدايا تحتاج ربط خدمات خلفية وRTC قبل النشر التجاري.
