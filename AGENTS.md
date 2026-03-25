# app2 - Industrial Process Management

**Generated:** 2026-03-25 12:35:12
**Stack:** Laravel 12 + Livewire 3 + Volt + Mary UI + PostgreSQL

## OVERVIEW
Manufacturing/industrial process management system with barcode scanning, Excel import/export, PDF generation, and real-time notifications.

## STRUCTURE
```
app2/app/
├── Actions/           # Not present - uses Services instead
├── Exports/           # Maatwebsite Excel exports (PccReport, templates)
├── Http/
│   ├── Controllers/   # LocaleController, API controllers
│   └── Middleware/     # SetLocale, Google2FA
├── Imports/           # Excel imports (HpmSchedule, FinishGood, HpmPcc)
├── Jobs/              # CleanupOldPdfFiles, PrintLabelsPCC
├── Models/
│   ├── Customer/HPM/  # Pcc, PccEvent, PccTrace, CCP, Schedule
│   ├── Master/        # FinishGood, Supplier, Customer
│   └── ScannerLock, User
├── Notifications/     # PrintJobComplete, ScannerLockedNotification
├── Services/          # PccTraceService (processes)
├── Traits/
│   └── Livewire/      # HasScannerLock, ProcessesScan, HasCrossCheckScan
└── View/Components/   # AccessibleDropdown, Menu, AppBrand
```

## DISTINCT DOMAIN (vs app1)
- **Livewire + Volt** instead of Inertia (server-rendered)
- **Industrial processes**: CCP, Schedule, Trace tracking
- **Barcode system**: Milon/barcode, scanner lock management
- **Excel imports**: Maatwebsite/excel for bulk data
- **PDF generation**: Spatie/laravel-pdf
- **2FA**: Google2FA for operator authentication
- **Permissions**: Spatie/laravel-permission
- **Webpush**: Laravel-notification-channels/webpush
- **Auto-translation**: vildanbina/laravel-auto-translation

## CONVENTIONS (this app)
- Use Livewire Volt syntax for new components
- Barcode operations via `HasScannerLock` trait
- Process scans via `ProcessesScan` trait
- Import classes handle validation + model creation
- Service classes encapsulate business logic (no Jobs in Services)

## WHERE TO LOOK
| Feature | Location |
|---------|----------|
| Barcode scanning | `Traits/Livewire/HasScannerLock.php` |
| Process trace | `Services/PccTraceService.php` |
| Excel import | `Imports/*.php` |
| PDF generation | Jobs using Spatie PDF |
| Scanner notifications | `Notifications/ScannerLockedNotification.php` |

## SKILLS
Activate when working in this app:
- `laravel-livewire` — Livewire component development
- `maatwebsite-excel` — Excel import/export patterns
