# PowerShell script to generate static HTML comparison site

$basePath = "C:\Users\matt\Documents\Uno\AI Generation\Prompt Comparison"
$outputFile = Join-Path $basePath "index.html"

# Performance data for summary
$performanceData = @(
    @{ Name = "1. Flight Details"; AntigravityTime = 80; UnoVSCodeTime = 150; UnoVSCodeMCPTime = 105; LovableTime = 180; LovableCredits = 2.1; LovablePages = 1; DreamflowTime = 200; DreamflowCredits = 3.4; DreamflowPages = 2; VibecodeTime = 780; VibecodeCredits = 1.96; VibecodePages = 1; BuilderTime = 380; BuilderCredits = 14; BuilderPages = 1; BoltTime = 95; BoltTokens = 99000; BoltPages = 1; TempoTime = 435; TempoCredits = 4.2; TempoPages = 1 }
    @{ Name = "2. Football Fantasy"; AntigravityTime = 65; UnoVSCodeTime = 110; UnoVSCodeMCPTime = 170; LovableTime = 420; LovableCredits = 2.9; LovablePages = 1; DreamflowTime = 500; DreamflowCredits = 11.5; DreamflowPages = 1; VibecodeTime = 1490; VibecodeCredits = 0.54; VibecodePages = 2; BuilderTime = 180; BuilderCredits = 5; BuilderPages = 3; BoltTime = 505; BoltTokens = 201000; BoltPages = 1; TempoTime = 875; TempoCredits = 5; TempoPages = 8 }
    @{ Name = "3. Travel Guide"; AntigravityTime = 80; UnoVSCodeTime = 120; UnoVSCodeMCPTime = 180; LovableTime = 230; LovableCredits = 2.4; LovablePages = 1; DreamflowTime = 170; DreamflowCredits = 4.1; DreamflowPages = 1; VibecodeTime = 540; VibecodeCredits = 1.1; VibecodePages = 1; BuilderTime = 160; BuilderCredits = 4; BuilderPages = 2; BoltTime = 305; BoltTokens = 300000; BoltPages = 1; TempoTime = 510; TempoCredits = 5; TempoPages = 1 }
    @{ Name = "4. Electric Utility Dashboard"; AntigravityTime = 95; UnoVSCodeTime = 115; UnoVSCodeMCPTime = 290; LovableTime = 160; LovableCredits = 1.8; LovablePages = 1; DreamflowTime = 220; DreamflowCredits = 3.9; DreamflowPages = 1; VibecodeTime = 240; VibecodeCredits = 0.5; VibecodePages = 1; BuilderTime = 155; BuilderCredits = 4; BuilderPages = 1; BoltTime = 225; BoltTokens = 188000; BoltPages = 1; TempoTime = 290; TempoCredits = 3.7; TempoPages = 1 }
    @{ Name = "5. Video Streaming"; AntigravityTime = 90; UnoVSCodeTime = 105; UnoVSCodeMCPTime = 160; LovableTime = 270; LovableCredits = 2.5; LovablePages = 2; DreamflowTime = 330; DreamflowCredits = 5.8; DreamflowPages = 4; VibecodeTime = 1080; VibecodeCredits = 6.37; VibecodePages = 2; BuilderTime = 160; BuilderCredits = 4; BuilderPages = 2; BoltTime = 350; BoltTokens = 300000; BoltPages = 1; TempoTime = 475; TempoCredits = 5; TempoPages = 1 }
    @{ Name = "6. Notes"; AntigravityTime = 90; UnoVSCodeTime = 275; UnoVSCodeMCPTime = 150; LovableTime = 180; LovableCredits = 2; LovablePages = 3; DreamflowTime = 210; DreamflowCredits = 3.8; DreamflowPages = 3; VibecodeTime = 450; VibecodeCredits = 1.49; VibecodePages = 1; BuilderTime = 125; BuilderCredits = 2; BuilderPages = 1; BoltTime = 160; BoltTokens = 131000; BoltPages = 1; TempoTime = 170; TempoCredits = 2; TempoPages = 1 }
    @{ Name = "7. Calendar"; AntigravityTime = 75; UnoVSCodeTime = 210; UnoVSCodeMCPTime = 230; LovableTime = 290; LovableCredits = 2.2; LovablePages = 1; DreamflowTime = 225; DreamflowCredits = 7; DreamflowPages = 1; VibecodeTime = 285; VibecodeCredits = 0.69; VibecodePages = 1; BuilderTime = 125; BuilderCredits = 3; BuilderPages = 1; BoltTime = 175; BoltTokens = 141000; BoltPages = 1; TempoTime = 270; TempoCredits = 2; TempoPages = 1 }
    @{ Name = "8. Hospital Dashboard"; AntigravityTime = 85; UnoVSCodeTime = 120; UnoVSCodeMCPTime = 150; LovableTime = 180; LovableCredits = 1.9; LovablePages = 1; DreamflowTime = 260; DreamflowCredits = 4.4; DreamflowPages = 1; VibecodeTime = 680; VibecodeCredits = 2.52; VibecodePages = 1; BuilderTime = 100; BuilderCredits = 2; BuilderPages = 1; BoltTime = 205; BoltTokens = 203000; BoltPages = 1; TempoTime = 270; TempoCredits = 2.9; TempoPages = 1 }
    @{ Name = "9. Budgeting Dashboard"; AntigravityTime = 80; UnoVSCodeTime = 160; UnoVSCodeMCPTime = 140; LovableTime = 150; LovableCredits = 1.7; LovablePages = 1; DreamflowTime = 240; DreamflowCredits = 5.4; DreamflowPages = 1; VibecodeTime = 1095; VibecodeCredits = 1.15; VibecodePages = 1; BuilderTime = 105; BuilderCredits = 2; BuilderPages = 1; BoltTime = 235; BoltTokens = 244000; BoltPages = 2; TempoTime = 220; TempoCredits = 2.9; TempoPages = 1 }
    @{ Name = "10. Recipe Home Screen"; AntigravityTime = 80; UnoVSCodeTime = 150; UnoVSCodeMCPTime = 170; LovableTime = 120; LovableCredits = 1.6; LovablePages = 1; DreamflowTime = 185; DreamflowCredits = 4.5; DreamflowPages = 1; VibecodeTime = 270; VibecodeCredits = 0.54; VibecodePages = 1; BuilderTime = 95; BuilderCredits = 2; BuilderPages = 1; BoltTime = 80; BoltTokens = 79000; BoltPages = 1; TempoTime = 250; TempoCredits = 3.3; TempoPages = 2 }
    @{ Name = "11. Fitness Tracking"; AntigravityTime = 75; UnoVSCodeTime = 120; UnoVSCodeMCPTime = 180; LovableTime = 200; LovableCredits = 1.9; LovablePages = 1; DreamflowTime = 240; DreamflowCredits = 3.5; DreamflowPages = 1; VibecodeTime = 240; VibecodeCredits = 0.51; VibecodePages = 1; BuilderTime = 120; BuilderCredits = 3; BuilderPages = 1; BoltTime = 120; BoltTokens = 84000; BoltPages = 1; TempoTime = 240; TempoCredits = 3; TempoPages = 1 }
    @{ Name = "12. Login Register"; AntigravityTime = 60; UnoVSCodeTime = 90; UnoVSCodeMCPTime = 300; LovableTime = 155; LovableCredits = 2.1; LovablePages = 2; DreamflowTime = 255; DreamflowCredits = 3.5; DreamflowPages = 2; VibecodeTime = 330; VibecodeCredits = 0.82; VibecodePages = 1; BuilderTime = 110; BuilderCredits = 2; BuilderPages = 1; BoltTime = 300; BoltTokens = 300000; BoltPages = 1; TempoTime = 270; TempoCredits = 3.3; TempoPages = 1 }
    @{ Name = "13. Travel Home Screen"; AntigravityTime = 75; UnoVSCodeTime = 400; UnoVSCodeMCPTime = 240; LovableTime = 210; LovableCredits = 2.1; LovablePages = 1; DreamflowTime = 220; DreamflowCredits = 8.5; DreamflowPages = 1; VibecodeTime = 270; VibecodeCredits = 0.57; VibecodePages = 1; BuilderTime = 200; BuilderCredits = 6; BuilderPages = 1; BoltTime = 250; BoltTokens = 235000; BoltPages = 1; TempoTime = 220; TempoCredits = 2.9; TempoPages = 1 }
    @{ Name = "14. Burger Joint"; AntigravityTime = 80; UnoVSCodeTime = 100; UnoVSCodeMCPTime = 330; LovableTime = 200; LovableCredits = 1.8; LovablePages = 1; DreamflowTime = 225; DreamflowCredits = 3.4; DreamflowPages = 1; VibecodeTime = 295; VibecodeCredits = 0.61; VibecodePages = 1; BuilderTime = 175; BuilderCredits = 5; BuilderPages = 1; BoltTime = 100; BoltTokens = 105000; BoltPages = 1; TempoTime = 410; TempoCredits = 5; TempoPages = 3 }
    @{ Name = "15. Fitness Home Screen"; AntigravityTime = 0; UnoVSCodeTime = 0; UnoVSCodeMCPTime = 0; LovableTime = 0; LovableCredits = 0; LovablePages = 1; DreamflowTime = 0; DreamflowCredits = 0; DreamflowPages = 1; VibecodeTime = 540; VibecodeCredits = 1.24; VibecodePages = 1; BuilderTime = 235; BuilderCredits = 6; BuilderPages = 1; BoltTime = 135; BoltTokens = 131000; BoltPages = 1; TempoTime = 290; TempoCredits = 3.5; TempoPages = 5 }
    @{ Name = "16. Background Dashboard"; AntigravityTime = 0; UnoVSCodeTime = 0; UnoVSCodeMCPTime = 0; LovableTime = 0; LovableCredits = 0; LovablePages = 1; DreamflowTime = 0; DreamflowCredits = 0; DreamflowPages = 1; VibecodeTime = 445; VibecodeCredits = 1.22; VibecodePages = 1; BuilderTime = 145; BuilderCredits = 3; BuilderPages = 1; BoltTime = 120; BoltTokens = 116000; BoltPages = 1; TempoTime = 320; TempoCredits = 3.7; TempoPages = 1 }
    @{ Name = "17. Login Email Phone"; AntigravityTime = 0; UnoVSCodeTime = 0; UnoVSCodeMCPTime = 0; LovableTime = 0; LovableCredits = 0; LovablePages = 1; DreamflowTime = 0; DreamflowCredits = 0; DreamflowPages = 1; VibecodeTime = 380; VibecodeCredits = 0.92; VibecodePages = 1; BuilderTime = 155; BuilderCredits = 4; BuilderPages = 1; BoltTime = 90; BoltTokens = 107000; BoltPages = 1; TempoTime = 160; TempoCredits = 1.5; TempoPages = 1 }
    @{ Name = "18. MeowFlix"; AntigravityTime = 0; UnoVSCodeTime = 0; UnoVSCodeMCPTime = 0; LovableTime = 0; LovableCredits = 0; LovablePages = 1; DreamflowTime = 0; DreamflowCredits = 0; DreamflowPages = 1; VibecodeTime = 730; VibecodeCredits = 1.52; VibecodePages = 2; BuilderTime = 120; BuilderCredits = 2; BuilderPages = 1; BoltTime = 135; BoltTokens = 141000; BoltPages = 1; TempoTime = 375; TempoCredits = 4.9; TempoPages = 1 }
)

# Google Drive video links (Vibecode demos)
$vibecodeDriveLinks = @{
    "1. Flight Details" = "https://drive.google.com/file/d/1gYwTFgJFAASlSrPR1S-TufUK5e7FOcmF/view?usp=drive_link"
    "2. Football Fantasy" = "https://drive.google.com/file/d/10ce_zHgYFgtVQqZ7yKi1AXs5joqrf2Bc/view?usp=drive_link"
    "3. Travel Guide" = "https://drive.google.com/file/d/1Ola-DlEJsEfwu39D_2Aw-1JYQFAtnxWN/view?usp=drive_link"
    "4. Electric Utility Dashboard" = "https://drive.google.com/file/d/16NsWe7XNNoQSsY919ADpm606UovpTcdY/view?usp=drive_link"
    "5. Video Streaming" = "https://drive.google.com/file/d/1F5PSits1L1twL_DAb-MDCXSSJpAwSUr0/view?usp=drive_link"
    "6. Notes" = "https://drive.google.com/file/d/1UcfDK7OgOsCeKFrRDRTZ0KzVXGfu6_yX/view?usp=drive_link"
    "7. Calendar" = "https://drive.google.com/file/d/1Ql6dduAL5d8IxnqDfEaOZ_AFG-NH0dMM/view?usp=drive_link"
    "8. Hospital Dashboard" = "https://drive.google.com/file/d/1vD6cm8j6U7xcmNgzaSFGSx0JMvV5Ww76/view?usp=drive_link"
    "9. Budgeting Dashboard" = "https://drive.google.com/file/d/1M4tleZnCU6S46hGJd9-XIu_QI37Uslo5/view?usp=drive_link"
    "10. Recipe Home Screen" = "https://drive.google.com/file/d/15gdCxNPkIufHX6_kVdUP1BvOi3Jn1EoD/view?usp=drive_link"
    "11. Fitness Tracking" = "https://drive.google.com/file/d/1v0eTqJsCSPgbs0YdEcn1sL4S9aEdI-fo/view?usp=drive_link"
    "12. Login Register" = "https://drive.google.com/file/d/1f3nuNreNcXlbzEtLRWOdLjYcihJFzRwU/view?usp=drive_link"
    "13. Travel Home Screen" = "https://drive.google.com/file/d/1BwqaTFYFFi8cZdeeIG1VPQhzflBxN3WQ/view?usp=drive_link"
    "14. Burger Joint" = "https://drive.google.com/file/d/184Asoy5O7mKh2UCtnANwKi_aMtUwG0xX/view?usp=drive_link"
    "15. Fitness Home Screen" = "https://drive.google.com/file/d/13YULDvowxo7nlL0ohsEJqBrH2A3_0S5S/view?usp=drive_link"
    "16. Background Dashboard" = "https://drive.google.com/file/d/1V2IgSL3AYRiisaroJDioptomDd73AwOu/view?usp=drive_link"
    "17. Login Email Phone" = "https://drive.google.com/file/d/1V2IgSL3AYRiisaroJDioptomDd73AwOu/view?usp=drive_link"
    "18. MeowFlix" = "https://drive.google.com/file/d/18mLYLer1mv_NBX6ibFTvC5Dc8lG8qPhS/view?usp=drive_link"
}

# Google Drive video links (Builder demos)
$builderDriveLinks = @{
    "1. Flight Details" = "https://drive.google.com/file/d/1i6wLoFj_wG9O6X0nQS10nOI8pEqK3tnj/view?usp=drive_link"
    "2. Football Fantasy" = "https://drive.google.com/file/d/1-c1pPXjp2s4ooIrJ0-Cwyq06l5udRJ1f/view?usp=drive_link"
    "3. Travel Guide" = "https://drive.google.com/file/d/1EDBKBO5VXPTJB1QnJu7xOApN-kSVycRn/view?usp=drive_link"
    "4. Electric Utility Dashboard" = "https://drive.google.com/file/d/1HDYn3pKRHfyceAwjTGoYmwKUJtd9i1XU/view?usp=drive_link"
    "5. Video Streaming" = "https://drive.google.com/file/d/1dtWEB6qvXJDh80M3U1x-dlW9vRyGuiMS/view?usp=drive_link"
    "6. Notes" = "https://drive.google.com/file/d/1zqjmkv-ymkhPJRRWzrrw0Fe4jghPdS2m/view?usp=drive_link"
    "7. Calendar" = "https://drive.google.com/file/d/1iHIpZrnPtERPXbRM9APkoEOQmleDuJg4/view?usp=drive_link"
    "8. Hospital Dashboard" = "https://drive.google.com/file/d/1vlydaX1-hQR07IW7Br24O9U60FwgreES/view?usp=drive_link"
    "9. Budgeting Dashboard" = "https://drive.google.com/file/d/1EqSMqLDtU0n5Gemh5f2E4XSFseDrUg-S/view?usp=drive_link"
    "10. Recipe Home Screen" = "https://drive.google.com/file/d/18PbUQl-VqbIEBBwAvvQIIl-1W89zB6C7/view?usp=drive_link"
    "11. Fitness Tracking" = "https://drive.google.com/file/d/1FTeyez7tgyXALKyAuUZ9xe6Rsll44vLL/view?usp=drive_link"
    "12. Login Register" = "https://drive.google.com/file/d/1zbJqPBRyKQV1xGal_NrX2u9T_qFWQ_Jq/view?usp=drive_link"
    "13. Travel Home Screen" = "https://drive.google.com/file/d/1CX7-0hS-tg39sdwki-iTqKFDkdY2mKqY/view?usp=drive_link"
    "14. Burger Joint" = "https://drive.google.com/file/d/1izMJyEkYVL62ptI-QjeL0nckSWhhS7vl/view?usp=drive_link"
    "15. Fitness Home Screen" = "https://drive.google.com/file/d/1Lhc8GRO6peAqAQvlk1jtZRwvPXVSk2ci/view?usp=drive_link"
    "16. Background Dashboard" = "https://drive.google.com/file/d/1j8gtYtszJNfQ72A1P0IB3TBbeELdkvBq/view?usp=drive_link"
    "17. Login Email Phone" = "https://drive.google.com/file/d/1KaH7EEQjtiysAoDFIAULe6EfPVas-ewc/view?usp=drive_link"
    "18. MeowFlix" = "https://drive.google.com/file/d/1HFHJ2Fbgh7j3ws-eOaGKhu64Zwo547UN/view?usp=drive_link"
}

# Google Drive video links (Bolt demos)
$boltDriveLinks = @{
    "1. Flight Details" = "https://drive.google.com/file/d/1SNYktZUdHAf2q28MvKk_DmLNDrYElwrB/view?usp=drive_link"
    "2. Football Fantasy" = "https://drive.google.com/file/d/1zxUiLWcyqDrWuI5o3nclDTJBsF2LcQMh/view?usp=drive_link"
    "3. Travel Guide" = "https://drive.google.com/file/d/1wESirzeF57tRYZqkLQN06xUCGfCRsA8G/view?usp=drive_link"
    "4. Electric Utility Dashboard" = "https://drive.google.com/file/d/1IrRdPBX0-5N-I5EjKPxJQoKRn6pI6BBk/view?usp=drive_link"
    "5. Video Streaming" = "https://drive.google.com/file/d/1CtLcbWFRmj8wgimYWe8P-2wTKrzb39mw/view?usp=drive_link"
    "6. Notes" = "https://drive.google.com/file/d/14gQx2vpCSqBIylWpp0s-T8QyY8zR8YTy/view?usp=drive_link"
    "7. Calendar" = "https://drive.google.com/file/d/1hpc1tQ1-M5F15pCAQzzYQkGXELqOEw6I/view?usp=drive_link"
    "8. Hospital Dashboard" = "https://drive.google.com/file/d/1dFPi08toVxuiBk_D-mz769UtQXegitQw/view?usp=drive_link"
    "9. Budgeting Dashboard" = "https://drive.google.com/file/d/1i8H-usT9xyaUB0GTuZnjAyw8vpQC68Rp/view?usp=drive_link"
    "10. Recipe Home Screen" = "https://drive.google.com/file/d/1hAs418Ctj1mXSUmq7UEkwe5l7cV7mI2A/view?usp=drive_link"
    "11. Fitness Tracking" = "https://drive.google.com/file/d/1koPDB1abVglplT2zpxssFEcjfBhBB0K8/view?usp=drive_link"
    "12. Login Register" = "https://drive.google.com/file/d/1u7HRpa74e1s6Cp5fFr9xz1gy0CLiOivM/view?usp=drive_link"
    "13. Travel Home Screen" = "https://drive.google.com/file/d/1-hAvJCsGhPzyNJCAZafeJY8BIb7IwYnM/view?usp=drive_link"
    "14. Burger Joint" = "https://drive.google.com/file/d/193RQWOEoADH4yVMIZ6A9od6Nk2kpiLw8/view?usp=drive_link"
    "15. Fitness Home Screen" = "https://drive.google.com/file/d/1sepyQtf1jXiLAJCxzfgiC42pOz62DMdl/view?usp=drive_link"
    "16. Background Dashboard" = "https://drive.google.com/file/d/1h5bTmpcYMqkfziY0qWQsE1emu7sfI4oH/view?usp=drive_link"
    "17. Login Email Phone" = "https://drive.google.com/file/d/1hkwVVi3oijANckZ3OJ-i8OlFrGz7R_77/view?usp=drive_link"
    "18. MeowFlix" = "https://drive.google.com/file/d/1NGqdTow7XYmQJ1NXngcB40s0dwNaJ3f9/view?usp=drive_link"
}

# Google Drive video links (Tempo demos)
$tempoDriveLinks = @{
    "1. Flight Details" = "https://drive.google.com/file/d/1ba_V_vNdR10PucP-R5uiF6uLRuSogf5N/view?usp=drive_link"
    "2. Football Fantasy" = "https://drive.google.com/file/d/1qM8AHkO43CVKoqMl2t25wBD_uLu6f5oc/view?usp=drive_link"
    "3. Travel Guide" = "https://drive.google.com/file/d/1W3wPVEwB9gjvHp9mAMKC5Y3g7QdhaQvr/view?usp=drive_link"
    "4. Electric Utility Dashboard" = "https://drive.google.com/file/d/1JyBViAhDqAzAAj8ht9s90uDGlyYbP5xb/view?usp=drive_link"
    "5. Video Streaming" = "https://drive.google.com/file/d/1Kt3DAOdsOTcSEVDp0rD5imfgBFJFSpTS/view?usp=drive_link"
    "6. Notes" = "https://drive.google.com/file/d/1-fTaZfY1mkCeRa2Qfi_DU5C88uxKSfsT/view?usp=drive_link"
    "7. Calendar" = "https://drive.google.com/file/d/1JNjSaBuhsOTNOLeU4RFBNHe8Q-MS1rDD/view?usp=drive_link"
    "8. Hospital Dashboard" = "https://drive.google.com/file/d/1yLal2wHSAbF5aVNhqJvqRDHrLaTbbi44/view?usp=drive_link"
    "9. Budgeting Dashboard" = "https://drive.google.com/file/d/1hqNDdo-73l_ijKzui8G_DTuBUZ9hQAzR/view?usp=drive_link"
    "10. Recipe Home Screen" = "https://drive.google.com/file/d/1bG5lZSJ75VwlT_73BTwF6GZubqZ5O6mO/view?usp=drive_link"
    "11. Fitness Tracking" = "https://drive.google.com/file/d/1yMsxK6DsmnhPSMlxDhPQn4lNDg1R0gU_/view?usp=drive_link"
    "12. Login Register" = "https://drive.google.com/file/d/1TCWDhGctHe7twCwvto-u6uIikYLklNX0/view?usp=drive_link"
    "13. Travel Home Screen" = "https://drive.google.com/file/d/1P9rPi3xaXsLwpyoE16-iHaOs1NBEmaUi/view?usp=drive_link"
    "14. Burger Joint" = "https://drive.google.com/file/d/1FlC-znJwjTmNJYSaGJS_cOF4ZKBrGguH/view?usp=drive_link"
    "15. Fitness Home Screen" = "https://drive.google.com/file/d/1585TQBeaJDEfvcNVpBtoaCpleli2Hmfo/view?usp=drive_link"
    "16. Background Dashboard" = "https://drive.google.com/file/d/1GQIN_kvpTNMFxB_0XFO-PUKK_iLojLzZ/view?usp=drive_link"
    "17. Login Email Phone" = "https://drive.google.com/file/d/1zHmqhU1MFaNkvNK93Kquwn6lls9YMNv1/view?usp=drive_link"
    "18. MeowFlix" = "https://drive.google.com/file/d/1YgeSpZHoxOLwECCETmSd6NkLS6T2TWhY/view?usp=drive_link"
}

# Get all project folders and sort numerically
$folders = Get-ChildItem $basePath -Directory | Where-Object { $_.Name -ne "Comparison" -and $_.Name -ne ".vscode" -and $_.Name -ne ".git" } | Sort-Object { 
    if ($_.Name -match '^(\d+)') { 
        [int]$matches[1] 
    } else { 
        999 
    }
}

$projectsData = @()

foreach ($folder in $folders) {
    $folderName = $folder.Name
    $folderPath = $folder.FullName
    
    # Map folder names to display names
    $projectName = $folderName
    if ($folderName -eq "17. LoginEmailPhone") {
        $projectName = "17. Login Email Phone"
    }
    
    Write-Host "Processing: $projectName"
    
    # Read prompts
    $promptsFile = Join-Path $folderPath "Prompts.txt"
    $prompts = ""
    if (Test-Path $promptsFile) {
        $prompts = Get-Content $promptsFile -Raw -Encoding UTF8
        # Fix common UTF-8 encoding issues
        $prompts = $prompts -replace [char]0x2192, '->'
        $prompts = $prompts -replace [char]0x201C, '"'
        $prompts = $prompts -replace [char]0x201D, '"'
        $prompts = $prompts -replace [char]0x2026, '...'
        $prompts = $prompts -replace [char]0x2014, '-'
        $prompts = $prompts -replace [char]0x00D7, 'x'
        $prompts = $prompts -replace [char]0x20AC, 'EUR'
        $prompts = $prompts -replace [char]0x2605, '*'
        $prompts = $prompts -replace [char]0x2019, "'"
    }
    
    # Get all images (PNG, JPG, JPEG)
    $images = Get-ChildItem $folderPath -File | Where-Object { $_.Extension -match '\.(png|jpg|jpeg)$' }
    
    $projectData = @{
        Name = $projectName
        Prompts = $prompts
        Images = @()
        InspirationImages = @()
        VibecodeVideoUrl = $vibecodeDriveLinks[$projectName]
        BuilderVideoUrl = $builderDriveLinks[$projectName]
        BoltVideoUrl = $boltDriveLinks[$projectName]
        TempoVideoUrl = $tempoDriveLinks[$projectName]
    }
    
    foreach ($image in $images) {
        $imageName = $image.Name
        $tool = "other"
        $label = $imageName
        
        # Check if this is an inspiration image
        if ($imageName -match "^Inspiration") {
            $projectData.InspirationImages += @{
                Name = $imageName
                RelativePath = "$folderName/$imageName"
            }
            continue
        }
        
        if ($imageName -match "^Antigravity") {
            $tool = "antigravity"
        } elseif ($imageName -match "^UnoVSCodeMCP") {
            $tool = "vscodeunomcp"
        } elseif ($imageName -match "^VSCodeUnoMCP") {
            $tool = "vscodeunomcp"
        } elseif ($imageName -match "^UnoVSCode") {
            $tool = "vscodeuno"
        } elseif ($imageName -match "^VSCodeUno") {
            $tool = "vscodeuno"
        } elseif ($imageName -match "^UnoHD") {
            $tool = "uno"
        } elseif ($imageName -match "^Lovable") {
            $tool = "lovable"
        } elseif ($imageName -match "^Dreamflow") {
            $tool = "dreamflow"
        } elseif ($imageName -match "^Vibecode") {
            $tool = "vibecode"
        } elseif ($imageName -match "^Builder") {
            $tool = "builder"
        } elseif ($imageName -match "^Bolt") {
            $tool = "bolt"
        } elseif ($imageName -match "^Tempo") {
            $tool = "tempo"
        }
        
        $projectData.Images += @{
            Name = $imageName
            Tool = $tool
            Label = $imageName
            RelativePath = "$folderName/$imageName"
        }
    }
    
    # Sort images with natural sorting (handles numbers properly)
    # FirstGen files should appear first for their prefix
    $projectData.Images = $projectData.Images | Sort-Object { 
        # Extract prefix (everything before -FirstGen or -number)
        $name = $_.Name
        
        if ($name -match '^(.*?)-FirstGen') {
            # FirstGen images: use prefix and sort order 0
            $prefix = $matches[1]
            return @($prefix, 0, "")
        } elseif ($name -match '^(.*?)-(\d+)') {
            # Numbered images: use prefix and number + 1
            $prefix = $matches[1]
            $number = [int]$matches[2] + 1
            return @($prefix, $number, "")
        } else {
            # Other images: use full name
            return @($name, 999, "")
        }
    }
    
    $projectsData += $projectData
}

# Generate HTML
$html = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Generation Comparison - Uno vs Lovable vs Dreamflow</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            line-height: 1.6;
            color: #333;
            background: #f5f7fa;
            min-height: 100vh;
        }

        header {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            padding: 2.5rem 2rem;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            border-bottom: 3px solid #1e3c72;
        }

        header h1 {
            color: #ffffff;
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .subtitle {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.1rem;
            font-weight: 400;
        }

        .container {
            display: flex;
            max-width: 95%;
            margin: 2rem auto;
            gap: 2rem;
            padding: 0 1rem;
        }

        @media (min-width: 2400px) {
            .container {
                max-width: 2400px;
            }
        }

        .sidebar {
            width: 300px;
            background: #ffffff;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            max-height: calc(100vh - 200px);
            overflow-y: auto;
            position: sticky;
            top: 2rem;
            border: 1px solid #e1e8ed;
        }

        .sidebar h2 {
            margin-bottom: 1rem;
            color: #1e3c72;
            font-size: 1.5rem;
            font-weight: 600;
        }

        .project-list {
            list-style: none;
        }

        .project-list li {
            padding: 0.75rem 1rem;
            margin-bottom: 0.5rem;
            background: #f8fafc;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s ease;
            border-left: 3px solid transparent;
            color: #334155;
            font-weight: 500;
        }

        .project-list li:hover {
            background: #e8f2ff;
            transform: translateX(5px);
            border-left-color: #2a5298;
            color: #1e3c72;
        }

        .project-list li.active {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            font-weight: 600;
            border-left-color: #1e3c72;
            box-shadow: 0 2px 6px rgba(30, 60, 114, 0.3);
        }

        .main-content {
            flex: 1;
            background: #ffffff;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            min-height: 500px;
            border: 1px solid #e1e8ed;
        }

        .project-section {
            display: none;
        }

        .project-section.active {
            display: block;
        }

        .project-header h2 {
            color: #1e3c72;
            font-size: 2rem;
            margin-bottom: 1.5rem;
            border-bottom: 3px solid #2a5298;
            padding-bottom: 0.5rem;
            font-weight: 600;
        }

        .view-switcher {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 2rem;
            justify-content: center;
        }

        .view-btn {
            padding: 0.75rem 2rem;
            border: 2px solid #1e3c72;
            background: white;
            color: #1e3c72;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .view-btn:hover {
            background: #1e3c72;
            color: white;
        }

        .view-btn.active {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            border-color: transparent;
            box-shadow: 0 2px 6px rgba(30, 60, 114, 0.3);
        }

        .summary-table th[data-view],
        .summary-table td[data-view] {
            display: none;
        }

        .summary-table th[data-view].view-active,
        .summary-table td[data-view].view-active {
            display: table-cell;
        }

        .prompts-section {
            background: #f8fafc;
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 4rem;
            border: 1px solid #e1e8ed;
        }

        .prompts-section h3 {
            color: #1e3c72;
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .inspiration-section {
            background: #ffffff;
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            border: 2px solid #2a5298;
        }

        .inspiration-section h3 {
            color: #1e3c72;
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .inspiration-image {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            cursor: pointer;
            transition: transform 0.2s ease;
        }

        .inspiration-image:hover {
            transform: scale(1.02);
        }

        .tool-section {
            margin-bottom: 1.5rem;
            padding: 1rem;
            background: white;
            border-radius: 8px;
            border-left: 4px solid #1e3c72;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        }

        .tool-section.uno {
            border-left-color: #4a5568;
        }

        .tool-section.lovable {
            border-left-color: #e74c3c;
        }

        .tool-section.dreamflow {
            border-left-color: #16a085;
        }

        .tool-section h4 {
            color: #1e3c72;
            margin-bottom: 0.5rem;
            font-size: 1.1rem;
            font-weight: 600;
        }

        .tool-section-single {
            padding: 1rem;
            background: white;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        }

        .tool-section pre, .tool-section-single pre {
            white-space: pre-wrap;
            font-family: 'Courier New', monospace;
            font-size: 0.95rem;
            line-height: 1.8;
            color: #333;
            margin: 0;
        }

        .prompt-container {
            position: relative;
            margin-bottom: 1rem;
        }

        .prompt-container:last-child {
            margin-bottom: 0;
        }

        .copy-btn {
            position: absolute;
            top: 8px;
            right: 8px;
            background: #1e3c72;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 8px;
            cursor: pointer;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: all 0.2s ease;
            opacity: 0.9;
            z-index: 10;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .copy-btn:hover {
            background: #2a5298;
            opacity: 1;
            transform: translateY(-1px);
            box-shadow: 0 3px 6px rgba(0, 0, 0, 0.3);
        }

        .copy-btn:active {
            transform: translateY(0);
        }

        .copy-btn.copied {
            background: #16a085;
        }

        .copy-icon {
            width: 18px;
            height: 18px;
            display: block;
        }

        .prompt-container pre {
            padding-top: 35px;
        }

        .tabs {
            display: flex;
            gap: 1rem;
            margin-top: 4rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
        }

        .tab-button {
            padding: 0.75rem 1.5rem;
            border: 2px solid #1e3c72;
            background: white;
            color: #1e3c72;
            border-radius: 25px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .tab-button:hover {
            background: #1e3c72;
            color: white;
        }

        .tab-button.active {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            border-color: transparent;
            box-shadow: 0 2px 6px rgba(30, 60, 114, 0.3);
        }

        .tab-uno.active.active-tool {
            background: #4a5568;
            border-color: transparent;
        }

        .tab-lovable.active.active-tool {
            background: #e74c3c;
            border-color: transparent;
        }

        .tab-dreamflow.active.active-tool {
            background: #16a085;
            border-color: transparent;
        }

        .tab-vscodeuno.active.active-tool {
            background: #9b59b6;
            border-color: transparent;
        }

        .tab-vscodeunomcp.active.active-tool {
            background: #e67e22;
            border-color: transparent;
        }

        .tab-antigravity.active.active-tool {
            background: #3498db;
            border-color: transparent;
        }

        .tab-uno {
            border-color: #4a5568;
            color: #4a5568;
        }

        .tab-uno:hover {
            background: #4a5568;
            color: white;
        }

        .tab-vscodeuno {
            border-color: #9b59b6;
            color: #9b59b6;
        }

        .tab-vscodeuno:hover {
            background: #9b59b6;
            color: white;
        }

        .tab-vscodeunomcp {
            border-color: #e67e22;
            color: #e67e22;
        }

        .tab-vscodeunomcp:hover {
            background: #e67e22;
            color: white;
        }

        .tab-lovable {
            border-color: #e74c3c;
            color: #e74c3c;
        }

        .tab-lovable:hover {
            background: #e74c3c;
            color: white;
        }

        .tab-dreamflow {
            border-color: #16a085;
            color: #16a085;
        }

        .tab-dreamflow:hover {
            background: #16a085;
            color: white;
        }

        .tab-antigravity {
            border-color: #3498db;
            color: #3498db;
        }

        .tab-antigravity:hover {
            background: #3498db;
            color: white;
        }

        .tab-vibecode {
            border-color: #f39c12;
            color: #f39c12;
        }

        .tab-vibecode:hover {
            background: #f39c12;
            color: white;
        }

        .tab-vibecode.active.active-tool {
            background: #f39c12;
            border-color: transparent;
        }

        .tab-builder {
            border-color: #2ecc71;
            color: #2ecc71;
        }

        .tab-builder:hover {
            background: #2ecc71;
            color: white;
        }

        .tab-builder.active.active-tool {
            background: #2ecc71;
            border-color: transparent;
        }

        .tab-bolt {
            border-color: #1389FD;
            color: #1389FD;
        }

        .tab-bolt:hover {
            background: #1389FD;
            color: white;
        }

        .tab-bolt.active.active-tool {
            background: #1389FD;
            border-color: transparent;
        }

        .tab-tempo {
            border-color: #FF6B6B;
            color: #FF6B6B;
        }

        .tab-tempo:hover {
            background: #FF6B6B;
            color: white;
        }

        .tab-tempo.active.active-tool {
            background: #FF6B6B;
            border-color: transparent;
        }

        .images-grid {
            margin-top: 2rem;
        }

        .tool-group {
            margin-bottom: 3rem;
        }

        .tool-group:last-child {
            margin-bottom: 0;
        }

        .tool-group-header {
            margin-bottom: 1.5rem;
            padding: 1rem;
            border-radius: 8px;
            font-weight: 700;
            font-size: 1.2rem;
            text-align: center;
            color: white;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        }

        .tool-group-header.uno {
            background: linear-gradient(135deg, #4a5568 0%, #5a6a7a 100%);
        }

        .tool-group-header.lovable {
            background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
        }

        .tool-group-header.dreamflow {
            background: linear-gradient(135deg, #16a085 0%, #27ae60 100%);
        }

        .tool-group-header.vscodeuno {
            background: linear-gradient(135deg, #9b59b6 0%, #8e44ad 100%);
        }

        .tool-group-header.vscodeunomcp {
            background: linear-gradient(135deg, #e67e22 0%, #d35400 100%);
        }

        .tool-group-header.antigravity {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
        }

        .tool-group-header.vibecode {
            background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
        }

        .tool-group-header.builder {
            background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
        }

        .tool-group-header.bolt {
            background: linear-gradient(135deg, #1389FD 0%, #0D6FD8 100%);
        }

        .tool-group-header.tempo {
            background: linear-gradient(135deg, #FF6B6B 0%, #EE5A24 100%);
        }

        .video-container {
            width: 100%;
            max-width: 800px;
            margin: 0 auto 2rem;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .video-container iframe {
            width: 100%;
            height: 450px;
            border: none;
        }

        .tool-group-images {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2rem;
        }

        @media (max-width: 1400px) {
            .tool-group-images {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 900px) {
            .tool-group-images {
                grid-template-columns: 1fr;
            }
        }

        .image-card {
            background: #ffffff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 1px solid #e1e8ed;
            position: relative;
        }

        .image-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.12);
        }

        .image-card img {
            width: 100%;
            height: auto;
            display: block;
            cursor: pointer;
        }

        .material-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.4);
            z-index: 10;
        }

        .image-label {
            padding: 1rem;
            font-weight: 600;
            text-align: center;
        }

        .image-label.uno {
            background: linear-gradient(135deg, #4a5568 0%, #5a6a7a 100%);
            color: white;
        }

        .image-label.lovable {
            background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
            color: white;
        }

        .image-label.dreamflow {
            background: linear-gradient(135deg, #16a085 0%, #27ae60 100%);
            color: white;
        }

        .image-label.vscodeuno {
            background: linear-gradient(135deg, #9b59b6 0%, #8e44ad 100%);
            color: white;
        }

        .image-label.vscodeunomcp {
            background: linear-gradient(135deg, #e67e22 0%, #d35400 100%);
            color: white;
        }

        .image-label.tempo {
            background: linear-gradient(135deg, #FF6B6B 0%, #EE5A24 100%);
            color: white;
        }

        .summary-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 2rem;
            background: white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            border-radius: 8px;
            overflow: hidden;
        }

        .summary-table th {
            color: white;
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
        }

        .summary-table th:first-child {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            border-top-left-radius: 8px;
        }

        .summary-table th.tool-antigravity {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
        }

        .summary-table th.tool-uno,
        .summary-table th.tool-unomcp {
            background: linear-gradient(135deg, #7B68EE 0%, #6A5ACD 100%);
        }

        .summary-table th.tool-lovable {
            background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
        }

        .summary-table th.tool-dreamflow {
            background: linear-gradient(135deg, #16a085 0%, #27ae60 100%);
        }

        .summary-table th.tool-vibecode {
            background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
        }

        .summary-table th.tool-builder {
            background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
        }

        .summary-table th.tool-bolt {
            background: linear-gradient(135deg, #1389FD 0%, #0D6FD8 100%);
        }

        .summary-table th.tool-tempo {
            background: linear-gradient(135deg, #FF6B6B 0%, #EE5A24 100%);
        }

        .summary-table th:last-child {
            border-top-right-radius: 8px;
        }

        .value-better {
            color: #16a085;
        }

        .value-worse {
            color: #e74c3c;
        }

        .summary-table td {
            padding: 0.875rem 1rem;
            border-bottom: 1px solid #e1e8ed;
            color: #334155;
            font-size: 1rem;
        }

        .summary-table tr:last-child td {
            border-bottom: none;
            font-weight: 700;
            background: #f8fafc;
            font-size: 1.05rem;
        }

        .prompts-section .summary-table td {
            font-weight: normal;
            font-size: 1rem;
        }

        .prompts-section .summary-table tr:last-child td {
            font-weight: normal;
            font-size: 1rem;
            background: white;
        }

        .summary-table tr:hover:not(:last-child) {
            background: #f8fafc;
        }

        .prompts-section .summary-table tr:hover {
            background: #f8fafc;
        }

        .summary-table td:not(:first-child),
        .summary-table th:not(:first-child) {
            text-align: center;
        }

        .download-csv-btn {
            background: #f8fafc;
            color: #334155;
            border: 1px solid #cbd5e1;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            font-size: 0.85rem;
            font-weight: 500;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            transition: all 0.2s ease;
        }

        .download-csv-btn:hover {
            background: #e2e8f0;
            border-color: #94a3b8;
        }

        .project-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .project-header h2 {
            color: #1e3c72;
            font-size: 2rem;
            margin-bottom: 2rem;
            border-bottom: none;
            padding-bottom: 0;
            font-weight: 600;
        }

        .header-with-button {
            border-bottom: 3px solid #2a5298;
            padding-bottom: 0.5rem;
            margin-bottom: 1.5rem;
        }

        .summary-intro {
            background: linear-gradient(135deg, #f8fafc 0%, #e8f2ff 100%);
            padding: 2rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            border-left: 4px solid #2a5298;
        }

        .summary-intro h3 {
            color: #1e3c72;
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }

        .summary-intro p {
            color: #475569;
            line-height: 1.8;
            font-size: 1.05rem;
        }

        .lightbox {
            display: none;
            position: fixed;
            z-index: 1000;
            padding: 50px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.9);
        }

        .lightbox-content {
            margin: auto;
            display: block;
            max-width: 90%;
            max-height: 90%;
            object-fit: contain;
        }

        .lightbox-close {
            position: absolute;
            top: 15px;
            right: 35px;
            color: #f1f1f1;
            font-size: 40px;
            font-weight: bold;
            cursor: pointer;
        }

        .lightbox-close:hover {
            color: #bbb;
        }

        .lightbox-arrow {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            color: #f1f1f1;
            font-size: 60px;
            font-weight: bold;
            cursor: pointer;
            user-select: none;
            padding: 20px;
            transition: color 0.3s ease;
        }

        .lightbox-arrow:hover {
            color: #fff;
        }

        .lightbox-arrow.disabled {
            color: #555;
            cursor: not-allowed;
            opacity: 0.3;
        }

        .lightbox-arrow-left {
            left: 20px;
        }

        .lightbox-arrow-right {
            right: 20px;
        }

        .lightbox-caption {
            margin: auto;
            display: block;
            width: 80%;
            max-width: 700px;
            text-align: center;
            color: #ccc;
            padding: 10px 0;
            font-size: 1.2rem;
        }

        .sidebar::-webkit-scrollbar {
            width: 8px;
        }

        .sidebar::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }

        .sidebar::-webkit-scrollbar-thumb {
            background: #2c3e50;
            border-radius: 10px;
        }

        @media (max-width: 1024px) {
            .container {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                max-height: 300px;
                position: relative;
                top: 0;
            }

            .images-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }
        }

        @media (max-width: 768px) {
            header h1 {
                font-size: 1.8rem;
            }

            .images-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <header>
        <h1>AI Generation Comparison</h1>
        <p class="subtitle">Comparing Uno, Lovable, and Dreamflow outputs across different prompts</p>
    </header>

    <div class="container">
        <aside class="sidebar">
            <h2>Projects</h2>
            <ul class="project-list">
                <li data-project='summary' class='active' onclick='showProject("summary")'>Summary</li>
"@

# Add project list items
foreach ($project in $projectsData) {
    $projectId = $project.Name -replace '[^a-zA-Z0-9]', '_'
    $html += "                <li data-project='$projectId' onclick=""showProject('$projectId')"">$($project.Name)</li>`n"
}

$html += @"
            </ul>
        </aside>

        <main class="main-content">
            <div class="project-section active" id="summary">
                <div class="project-header header-with-button">
                    <h2>Performance Summary</h2>
                    <button class="download-csv-btn" onclick="downloadCSV()">Download CSV</button>
                </div>

                <div class="view-switcher">
                    <button class="view-btn active" onclick="switchTableView('time')">Time</button>
                    <button class="view-btn" onclick="switchTableView('credits')">Credits</button>
                    <button class="view-btn" onclick="switchTableView('cost')">Cost ($)</button>
                    <button class="view-btn" onclick="switchTableView('creditsperpage')">Credits / Page</button>
                    <button class="view-btn" onclick="switchTableView('costperpage')">Cost / Page ($)</button>
                </div>

                <table class="summary-table" id="performance-table">
                    <thead>
                        <tr>
                            <th>Project</th>
                            <th data-view="time" class="view-active tool-antigravity">Antigravity<br>Time (s)</th>
                            <th data-view="time" class="view-active tool-uno">Uno VS Code<br>Time (s)</th>
                            <th data-view="time" class="view-active tool-unomcp">Uno VS Code MCP<br>Time (s)</th>
                            <th data-view="time" class="view-active tool-lovable">Lovable<br>Time (s)</th>
                            <th data-view="credits" class="tool-lovable">Lovable<br>Credits</th>
                            <th data-view="cost" class="tool-lovable">Lovable<br>Cost ($)</th>
                            <th data-view="creditsperpage" class="tool-lovable">Lovable<br>Credits/Page</th>
                            <th data-view="costperpage" class="tool-lovable">Lovable<br>Cost/Page ($)</th>
                            <th data-view="time" class="view-active tool-dreamflow">Dreamflow<br>Time (s)</th>
                            <th data-view="credits" class="tool-dreamflow">Dreamflow<br>Credits</th>
                            <th data-view="cost" class="tool-dreamflow">Dreamflow<br>Cost ($)</th>
                            <th data-view="creditsperpage" class="tool-dreamflow">Dreamflow<br>Credits/Page</th>
                            <th data-view="costperpage" class="tool-dreamflow">Dreamflow<br>Cost/Page ($)</th>
                            <th data-view="time" class="view-active tool-vibecode">Vibecode<br>Time (s)</th>
                            <th data-view="cost" class="tool-vibecode">Vibecode<br>Cost ($)</th>
                            <th data-view="costperpage" class="tool-vibecode">Vibecode<br>Cost/Page ($)</th>
                            <th data-view="time" class="view-active tool-builder">Builder<br>Time (s)</th>
                            <th data-view="credits" class="tool-builder">Builder<br>Credits</th>
                            <th data-view="cost" class="tool-builder">Builder<br>Cost ($)</th>
                            <th data-view="creditsperpage" class="tool-builder">Builder<br>Credits/Page</th>
                            <th data-view="costperpage" class="tool-builder">Builder<br>Cost/Page ($)</th>
                            <th data-view="time" class="view-active tool-bolt">Bolt<br>Time (s)</th>
                            <th data-view="credits" class="tool-bolt">Bolt<br>Tokens</th>
                            <th data-view="cost" class="tool-bolt">Bolt<br>Cost ($)</th>
                            <th data-view="creditsperpage" class="tool-bolt">Bolt<br>Tokens/Page</th>
                            <th data-view="costperpage" class="tool-bolt">Bolt<br>Cost/Page ($)</th>
                            <th data-view="time" class="view-active tool-tempo">Tempo<br>Time (s)</th>
                            <th data-view="credits" class="tool-tempo">Tempo<br>Credits</th>
                            <th data-view="cost" class="tool-tempo">Tempo<br>Cost ($)</th>
                            <th data-view="creditsperpage" class="tool-tempo">Tempo<br>Credits/Page</th>
                            <th data-view="costperpage" class="tool-tempo">Tempo<br>Cost/Page ($)</th>
                        </tr>
                    </thead>
                    <tbody>
"@

# Add performance data rows
foreach ($data in $performanceData) {
    # Calculate costs and per-page values
    $lovableCost = [math]::Round($data.LovableCredits * 0.43, 2)
    $lovableCreditsPerPage = if ($data.LovablePages -gt 0) { [math]::Round($data.LovableCredits / $data.LovablePages, 2) } else { 0 }
    $lovableCostPerPage = if ($data.LovablePages -gt 0) { [math]::Round($lovableCost / $data.LovablePages, 2) } else { 0 }
    $dreamflowCost = [math]::Round($data.DreamflowCredits * 0.18, 2)
    $dreamflowCreditsPerPage = if ($data.DreamflowPages -gt 0) { [math]::Round($data.DreamflowCredits / $data.DreamflowPages, 2) } else { 0 }
    $dreamflowCostPerPage = if ($data.DreamflowPages -gt 0) { [math]::Round($dreamflowCost / $data.DreamflowPages, 2) } else { 0 }
    $vibecodeCostPerPage = if ($data.VibecodePages -gt 0) { [math]::Round($data.VibecodeCredits / $data.VibecodePages, 2) } else { 0 }
    $builderCost = [math]::Round($data.BuilderCredits * 0.048, 2)
    $builderCreditsPerPage = if ($data.BuilderPages -gt 0) { [math]::Round($data.BuilderCredits / $data.BuilderPages, 2) } else { 0 }
    $builderCostPerPage = if ($data.BuilderPages -gt 0) { [math]::Round($builderCost / $data.BuilderPages, 2) } else { 0 }
    $tempoCost = [math]::Round($data.TempoCredits * 0.20, 2)
    $tempoCreditsPerPage = if ($data.TempoPages -gt 0) { [math]::Round($data.TempoCredits / $data.TempoPages, 2) } else { 0 }
    $tempoCostPerPage = if ($data.TempoPages -gt 0) { [math]::Round($tempoCost / $data.TempoPages, 2) } else { 0 }
    
    # Get all time values for comparison
    $allTimes = @($data.AntigravityTime, $data.UnoVSCodeTime, $data.UnoVSCodeMCPTime, $data.LovableTime, $data.DreamflowTime, $data.VibecodeTime, $data.BuilderTime, $data.BoltTime, $data.TempoTime)
    $minTime = ($allTimes | Measure-Object -Minimum).Minimum
    $maxTime = ($allTimes | Measure-Object -Maximum).Maximum
    
    # Determine which tool is better for time (comparing all 6 tools)
    $antigravityTimeClass = if ($data.AntigravityTime -eq $minTime) { "value-better" } elseif ($data.AntigravityTime -eq $maxTime) { "value-worse" } else { "" }
    $unoVSCodeTimeClass = if ($data.UnoVSCodeTime -eq $minTime) { "value-better" } elseif ($data.UnoVSCodeTime -eq $maxTime) { "value-worse" } else { "" }
    $unoVSCodeMCPTimeClass = if ($data.UnoVSCodeMCPTime -eq $minTime) { "value-better" } elseif ($data.UnoVSCodeMCPTime -eq $maxTime) { "value-worse" } else { "" }
    $lovableTimeClass = if ($data.LovableTime -eq $minTime) { "value-better" } elseif ($data.LovableTime -eq $maxTime) { "value-worse" } else { "" }
    $dreamflowTimeClass = if ($data.DreamflowTime -eq $minTime) { "value-better" } elseif ($data.DreamflowTime -eq $maxTime) { "value-worse" } else { "" }
    $vibecodeTimeClass = if ($data.VibecodeTime -eq $minTime) { "value-better" } elseif ($data.VibecodeTime -eq $maxTime) { "value-worse" } else { "" }
    $builderTimeClass = if ($data.BuilderTime -eq $minTime) { "value-better" } elseif ($data.BuilderTime -eq $maxTime) { "value-worse" } else { "" }
    $boltTimeClass = if ($data.BoltTime -eq $minTime) { "value-better" } elseif ($data.BoltTime -eq $maxTime) { "value-worse" } else { "" }
    $tempoTimeClass = if ($data.TempoTime -eq $minTime) { "value-better" } elseif ($data.TempoTime -eq $maxTime) { "value-worse" } else { "" }
    
    # Determine which tool is better for credits
    $lovableCreditsClass = if ($data.LovableCredits -lt $data.DreamflowCredits -and $data.LovableCredits -lt $data.VibecodeCredits) { "value-better" } elseif ($data.LovableCredits -gt $data.DreamflowCredits -and $data.LovableCredits -gt $data.VibecodeCredits) { "value-worse" } else { "" }
    $dreamflowCreditsClass = if ($data.DreamflowCredits -lt $data.LovableCredits -and $data.DreamflowCredits -lt $data.VibecodeCredits) { "value-better" } elseif ($data.DreamflowCredits -gt $data.LovableCredits -and $data.DreamflowCredits -gt $data.VibecodeCredits) { "value-worse" } else { "" }
    $vibecodeCreditsClass = if ($data.VibecodeCredits -lt $data.LovableCredits -and $data.VibecodeCredits -lt $data.DreamflowCredits) { "value-better" } elseif ($data.VibecodeCredits -gt $data.LovableCredits -and $data.VibecodeCredits -gt $data.DreamflowCredits) { "value-worse" } else { "" }
    
    # Determine which tool is better for cost per page
    $lovableCostClass = if ($lovableCostPerPage -lt $dreamflowCostPerPage -and $lovableCostPerPage -lt $vibecodeCostPerPage) { "value-better" } elseif ($lovableCostPerPage -gt $dreamflowCostPerPage -and $lovableCostPerPage -gt $vibecodeCostPerPage) { "value-worse" } else { "" }
    $dreamflowCostClass = if ($dreamflowCostPerPage -lt $lovableCostPerPage -and $dreamflowCostPerPage -lt $vibecodeCostPerPage) { "value-better" } elseif ($dreamflowCostPerPage -gt $lovableCostPerPage -and $dreamflowCostPerPage -gt $vibecodeCostPerPage) { "value-worse" } else { "" }
    $vibecodeCostClass = if ($vibecodeCostPerPage -lt $lovableCostPerPage -and $vibecodeCostPerPage -lt $dreamflowCostPerPage) { "value-better" } elseif ($vibecodeCostPerPage -gt $lovableCostPerPage -and $vibecodeCostPerPage -gt $dreamflowCostPerPage) { "value-worse" } else { "" }
    
    # Display empty string for 0 values
    $antigravityTimeDisplay = if ($data.AntigravityTime -eq 0) { "" } else { $data.AntigravityTime }
    $unoVSCodeTimeDisplay = if ($data.UnoVSCodeTime -eq 0) { "" } else { $data.UnoVSCodeTime }
    $unoVSCodeMCPTimeDisplay = if ($data.UnoVSCodeMCPTime -eq 0) { "" } else { $data.UnoVSCodeMCPTime }
    $lovableTimeDisplay = if ($data.LovableTime -eq 0) { "" } else { $data.LovableTime }
    $lovableCreditsDisplay = if ($data.LovableCredits -eq 0) { "" } else { $data.LovableCredits }
    $lovableCostDisplay = if ($lovableCostPerPage -eq 0) { "" } else { $lovableCostPerPage }
    $dreamflowTimeDisplay = if ($data.DreamflowTime -eq 0) { "" } else { $data.DreamflowTime }
    $dreamflowCreditsDisplay = if ($data.DreamflowCredits -eq 0) { "" } else { $data.DreamflowCredits }
    $dreamflowCostDisplay = if ($dreamflowCostPerPage -eq 0) { "" } else { $dreamflowCostPerPage }
    $vibecodeTimeDisplay = if ($data.VibecodeTime -eq 0) { "" } else { $data.VibecodeTime }
    $vibecodeCreditsDisplay = if ($data.VibecodeCredits -eq 0) { "" } else { $data.VibecodeCredits }
    $vibecodeCostDisplay = if ($vibecodeCostPerPage -eq 0) { "" } else { $vibecodeCostPerPage }
    $builderTimeDisplay = if ($data.BuilderTime -eq 0) { "" } else { $data.BuilderTime }
    $builderCreditsDisplay = if ($data.BuilderCredits -eq 0) { "" } else { $data.BuilderCredits }
    $builderCostDisplay = if ($builderCost -eq 0) { "" } else { $builderCost }
    $builderCreditsPerPageDisplay = if ($builderCreditsPerPage -eq 0) { "" } else { $builderCreditsPerPage }
    $builderCostPerPageDisplay = if ($builderCostPerPage -eq 0) { "" } else { $builderCostPerPage }
    $boltTimeDisplay = if ($data.BoltTime -eq 0) { "" } else { $data.BoltTime }
    $boltTokensDisplay = if ($data.BoltTokens -eq 0) { "" } else { [math]::Round($data.BoltTokens / 1000, 0).ToString() + "k" }
    $boltTokensPerPage = if ($data.BoltPages -gt 0) { [math]::Round($data.BoltTokens / $data.BoltPages, 0) } else { 0 }
    $boltTokensPerPageDisplay = if ($boltTokensPerPage -eq 0) { "" } else { [math]::Round($boltTokensPerPage / 1000, 0).ToString() + "k" }
    $boltCost = [math]::Round($data.BoltTokens * 0.0000025, 2)
    $boltCostDisplay = if ($boltCost -eq 0) { "" } else { $boltCost }
    $boltCostPerPage = if ($data.BoltPages -gt 0 -and $data.BoltTokens -gt 0) { [math]::Round($boltCost / $data.BoltPages, 2) } else { 0 }
    $boltCostPerPageDisplay = if ($boltCostPerPage -eq 0) { "" } else { $boltCostPerPage }
    $lovableCostDisplay2 = if ($lovableCost -eq 0) { "" } else { $lovableCost }
    $lovableCreditsPerPageDisplay = if ($lovableCreditsPerPage -eq 0) { "" } else { $lovableCreditsPerPage }
    $dreamflowCostDisplay2 = if ($dreamflowCost -eq 0) { "" } else { $dreamflowCost }
    $dreamflowCreditsPerPageDisplay = if ($dreamflowCreditsPerPage -eq 0) { "" } else { $dreamflowCreditsPerPage }
    $tempoTimeDisplay = if ($data.TempoTime -eq 0) { "" } else { $data.TempoTime }
    $tempoCreditsDisplay = if ($data.TempoCredits -eq 0) { "" } else { $data.TempoCredits }
    $tempoCostDisplay = if ($tempoCost -eq 0) { "" } else { $tempoCost }
    $tempoCreditsPerPageDisplay = if ($tempoCreditsPerPage -eq 0) { "" } else { $tempoCreditsPerPage }
    $tempoCostPerPageDisplay = if ($tempoCostPerPage -eq 0) { "" } else { $tempoCostPerPage }
    
    $html += @"
                        <tr>
                            <td>$($data.Name)</td>
                            <td data-view="time" class="view-active $antigravityTimeClass">$antigravityTimeDisplay</td>
                            <td data-view="time" class="view-active $unoVSCodeTimeClass">$unoVSCodeTimeDisplay</td>
                            <td data-view="time" class="view-active $unoVSCodeMCPTimeClass">$unoVSCodeMCPTimeDisplay</td>
                            <td data-view="time" class="view-active $lovableTimeClass">$lovableTimeDisplay</td>
                            <td data-view="credits">$lovableCreditsDisplay</td>
                            <td data-view="cost">$lovableCostDisplay2</td>
                            <td data-view="creditsperpage">$lovableCreditsPerPageDisplay</td>
                            <td data-view="costperpage">$lovableCostDisplay</td>
                            <td data-view="time" class="view-active $dreamflowTimeClass">$dreamflowTimeDisplay</td>
                            <td data-view="credits">$dreamflowCreditsDisplay</td>
                            <td data-view="cost">$dreamflowCostDisplay2</td>
                            <td data-view="creditsperpage">$dreamflowCreditsPerPageDisplay</td>
                            <td data-view="costperpage">$dreamflowCostDisplay</td>
                            <td data-view="time" class="view-active $vibecodeTimeClass">$vibecodeTimeDisplay</td>
                            <td data-view="cost">$vibecodeCreditsDisplay</td>
                            <td data-view="costperpage">$vibecodeCostDisplay</td>
                            <td data-view="time" class="view-active $builderTimeClass">$builderTimeDisplay</td>
                            <td data-view="credits">$builderCreditsDisplay</td>
                            <td data-view="cost">$builderCostDisplay</td>
                            <td data-view="creditsperpage">$builderCreditsPerPageDisplay</td>
                            <td data-view="costperpage">$builderCostPerPageDisplay</td>
                            <td data-view="time" class="view-active $boltTimeClass">$boltTimeDisplay</td>
                            <td data-view="credits">$boltTokensDisplay</td>
                            <td data-view="cost">$boltCostDisplay</td>
                            <td data-view="creditsperpage">$boltTokensPerPageDisplay</td>
                            <td data-view="costperpage">$boltCostPerPageDisplay</td>
                            <td data-view="time" class="view-active $tempoTimeClass">$tempoTimeDisplay</td>
                            <td data-view="credits">$tempoCreditsDisplay</td>
                            <td data-view="cost">$tempoCostDisplay</td>
                            <td data-view="creditsperpage">$tempoCreditsPerPageDisplay</td>
                            <td data-view="costperpage">$tempoCostPerPageDisplay</td>
                        </tr>
"@
}

# Add averages row
$antigravityTotal = 0
$unoVSCodeTotal = 0
$unoVSCodeMCPTotal = 0
$lovableTimeTotal = 0
$lovableCreditsTotal = 0
$dreamflowTimeTotal = 0
$dreamflowCreditsTotal = 0
$vibecodeTimeTotal = 0
$vibecodeCreditsTotal = 0
$vibecodeCount = 0
$builderTimeTotal = 0
$builderCreditsTotal = 0
$builderCount = 0
$boltTimeTotal = 0
$boltTokensTotal = 0
$boltCount = 0
$tempoTimeTotal = 0
$tempoCreditsTotal = 0
$tempoCount = 0
foreach ($d in $performanceData) {
    $antigravityTotal += $d.AntigravityTime
    $unoVSCodeTotal += $d.UnoVSCodeTime
    $unoVSCodeMCPTotal += $d.UnoVSCodeMCPTime
    $lovableTimeTotal += $d.LovableTime
    $lovableCreditsTotal += $d.LovableCredits
    $dreamflowTimeTotal += $d.DreamflowTime
    $dreamflowCreditsTotal += $d.DreamflowCredits
    $vibecodeTimeTotal += $d.VibecodeTime
    $vibecodeCreditsTotal += $d.VibecodeCredits
    if ($d.VibecodeTime -gt 0) { $vibecodeCount++ }
    $builderTimeTotal += $d.BuilderTime
    $builderCreditsTotal += $d.BuilderCredits
    if ($d.BuilderTime -gt 0) { $builderCount++ }
    $boltTimeTotal += $d.BoltTime
    $boltTokensTotal += $d.BoltTokens
    if ($d.BoltTime -gt 0) { $boltCount++ }
    $tempoTimeTotal += $d.TempoTime
    $tempoCreditsTotal += $d.TempoCredits
    if ($d.TempoTime -gt 0) { $tempoCount++ }
}
$count = $performanceData.Count
$antigravityAvg = [math]::Round($antigravityTotal / $count, 1)
$unoVSCodeAvg = [math]::Round($unoVSCodeTotal / $count, 1)
$unoVSCodeMCPAvg = [math]::Round($unoVSCodeMCPTotal / $count, 1)
$lovableTimeAvg = [math]::Round($lovableTimeTotal / $count, 1)
$lovableCreditsAvg = [math]::Round($lovableCreditsTotal / $count, 1)
$dreamflowTimeAvg = [math]::Round($dreamflowTimeTotal / $count, 1)
$dreamflowCreditsAvg = [math]::Round($dreamflowCreditsTotal / $count, 1)
$vibecodeTimeAvg = if ($vibecodeCount -gt 0) { [math]::Round($vibecodeTimeTotal / $vibecodeCount, 1) } else { "" }
$vibecodeCreditsAvg = if ($vibecodeCount -gt 0) { [math]::Round($vibecodeCreditsTotal / $vibecodeCount, 2) } else { "" }
$vibecodeCostPerPageAvg = if ($vibecodeCount -gt 0) { [math]::Round($vibecodeCreditsTotal / $vibecodeCount, 2) } else { "" }
$builderTimeAvg = if ($builderCount -gt 0) { [math]::Round($builderTimeTotal / $builderCount, 1) } else { "" }
$builderCreditsAvg = if ($builderCount -gt 0) { [math]::Round($builderCreditsTotal / $builderCount, 1) } else { "" }
$builderCostAvg = if ($builderCount -gt 0) { [math]::Round(($builderCreditsTotal * 0.048) / $builderCount, 2) } else { "" }
$builderCreditsPerPageAvg = if ($builderCount -gt 0) { [math]::Round($builderCreditsTotal / $builderCount, 2) } else { "" }
$builderCostPerPageAvg = if ($builderCount -gt 0) { [math]::Round(($builderCreditsTotal * 0.048) / $builderCount, 2) } else { "" }
$lovableCostAvg = [math]::Round(($lovableCreditsTotal * 0.43) / $count, 2)
$lovableCreditsPerPageAvg = [math]::Round($lovableCreditsTotal / $count, 2)
$lovableCostPerPageAvg = [math]::Round(($lovableCreditsTotal * 0.43) / $count, 2)
$dreamflowCostAvg = [math]::Round(($dreamflowCreditsTotal * 0.18) / $count, 2)
$dreamflowCreditsPerPageAvg = [math]::Round($dreamflowCreditsTotal / $count, 2)
$dreamflowCostPerPageAvg = [math]::Round(($dreamflowCreditsTotal * 0.18) / $count, 2)
$boltTimeAvg = if ($boltCount -gt 0) { [math]::Round($boltTimeTotal / $boltCount, 1) } else { "" }
$boltTokensAvg = if ($boltCount -gt 0) { [math]::Round(($boltTokensTotal / $boltCount) / 1000, 0).ToString() + "k" } else { "" }
$boltTokensPerPageAvg = if ($boltCount -gt 0) { [math]::Round(($boltTokensTotal / $boltCount) / 1000, 0).ToString() + "k" } else { "" }
$boltCostAvg = if ($boltCount -gt 0) { [math]::Round(($boltTokensTotal * 0.0000025) / $boltCount, 2) } else { "" }
$boltCostPerPageAvg = if ($boltCount -gt 0) { [math]::Round(($boltTokensTotal * 0.0000025) / $boltCount, 2) } else { "" }
$tempoTimeAvg = if ($tempoCount -gt 0) { [math]::Round($tempoTimeTotal / $tempoCount, 1) } else { "" }
$tempoCreditsAvg = if ($tempoCount -gt 0) { [math]::Round($tempoCreditsTotal / $tempoCount, 1) } else { "" }
$tempoCostAvg = if ($tempoCount -gt 0) { [math]::Round(($tempoCreditsTotal * 0.20) / $tempoCount, 2) } else { "" }
$tempoCreditsPerPageAvg = if ($tempoCount -gt 0) { [math]::Round($tempoCreditsTotal / $tempoCount, 2) } else { "" }
$tempoCostPerPageAvg = if ($tempoCount -gt 0) { [math]::Round(($tempoCreditsTotal * 0.20) / $tempoCount, 2) } else { "" }

$html += @"
                        <tr>
                            <td>Average</td>
                            <td data-view="time" class="view-active">$antigravityAvg</td>
                            <td data-view="time" class="view-active">$unoVSCodeAvg</td>
                            <td data-view="time" class="view-active">$unoVSCodeMCPAvg</td>
                            <td data-view="time" class="view-active">$lovableTimeAvg</td>
                            <td data-view="credits">$lovableCreditsAvg</td>
                            <td data-view="cost">$lovableCostAvg</td>
                            <td data-view="creditsperpage">$lovableCreditsPerPageAvg</td>
                            <td data-view="costperpage">$lovableCostPerPageAvg</td>
                            <td data-view="time" class="view-active">$dreamflowTimeAvg</td>
                            <td data-view="credits">$dreamflowCreditsAvg</td>
                            <td data-view="cost">$dreamflowCostAvg</td>
                            <td data-view="creditsperpage">$dreamflowCreditsPerPageAvg</td>
                            <td data-view="costperpage">$dreamflowCostPerPageAvg</td>
                            <td data-view="time" class="view-active">$vibecodeTimeAvg</td>
                            <td data-view="cost">$vibecodeCreditsAvg</td>
                            <td data-view="costperpage">$vibecodeCostPerPageAvg</td>
                            <td data-view="time" class="view-active">$builderTimeAvg</td>
                            <td data-view="credits">$builderCreditsAvg</td>
                            <td data-view="cost">$builderCostAvg</td>
                            <td data-view="creditsperpage">$builderCreditsPerPageAvg</td>
                            <td data-view="costperpage">$builderCostPerPageAvg</td>
                            <td data-view="time" class="view-active">$boltTimeAvg</td>
                            <td data-view="credits">$boltTokensAvg</td>
                            <td data-view="cost">$boltCostAvg</td>
                            <td data-view="creditsperpage">$boltTokensPerPageAvg</td>
                            <td data-view="costperpage">$boltCostPerPageAvg</td>
                            <td data-view="time" class="view-active">$tempoTimeAvg</td>
                            <td data-view="credits">$tempoCreditsAvg</td>
                            <td data-view="cost">$tempoCostAvg</td>
                            <td data-view="creditsperpage">$tempoCreditsPerPageAvg</td>
                            <td data-view="costperpage">$tempoCostPerPageAvg</td>
                        </tr>
                    </tbody>
                </table>
            </div>

"@

# Add project sections
foreach ($project in $projectsData) {
    $projectId = $project.Name -replace '[^a-zA-Z0-9]', '_'
    
    $html += @"
            <div class="project-section" id="$projectId">
                <div class="project-header">
                    <h2>$($project.Name)</h2>
                </div>

"@

    # Add prompts section
    if ($project.Prompts) {
        $html += @"
                <div class="prompts-section">
                    <h3>Prompts</h3>
"@
        
        # Parse prompts
        $promptLines = $project.Prompts -split "`n"
        $currentTool = ""
        $defaultPrompt = @()
        $toolContent = @{
            "UNO" = @()
            "LOVABLE" = @()
            "DREAMFLOW" = @()
        }
        
        foreach ($line in $promptLines) {
            $trimmed = $line.Trim()
            if ($trimmed -eq "UNO" -or $trimmed -eq "LOVABLE" -or $trimmed -eq "DREAMFLOW") {
                $currentTool = $trimmed
            } elseif ($trimmed -eq "BUILDER" -or $trimmed -eq "BOLT" -or $trimmed -eq "TEMPO") {
                $currentTool = $trimmed
            } elseif ($trimmed -and $currentTool -eq "") {
                $defaultPrompt += $trimmed
            } elseif ($trimmed -and $currentTool -and $currentTool -ne "BUILDER" -and $currentTool -ne "BOLT" -and $currentTool -ne "TEMPO") {
                $toolContent[$currentTool] += $trimmed
            }
        }
        
        # Count how many tools have content
        $toolsWithContent = 0
        if ($toolContent["UNO"].Count -gt 0) { $toolsWithContent++ }
        if ($toolContent["LOVABLE"].Count -gt 0) { $toolsWithContent++ }
        if ($toolContent["DREAMFLOW"].Count -gt 0) { $toolsWithContent++ }
        if ($defaultPrompt.Count -gt 0) { $toolsWithContent++ }
        
        # If only one tool, don't show header
        $showHeaders = $toolsWithContent -gt 1
        
        # Render default prompt (text before any tool section)
        if ($defaultPrompt.Count -gt 0) {
            $defaultText = ($defaultPrompt -join "`n")
            $defaultText = $defaultText -replace '<', '&lt;' -replace '>', '&gt;'
            
            $html += @"
                    <div class="tool-section-single">
                        <div class="prompt-container">
                            <button class="copy-btn" onclick="copyPrompt(this)" title="Copy to clipboard">
                                <svg class="copy-icon" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M8 3a1 1 0 011-1h2a1 1 0 110 2H9a1 1 0 01-1-1z"></path>
                                    <path d="M6 3a2 2 0 00-2 2v11a2 2 0 002 2h8a2 2 0 002-2V5a2 2 0 00-2-2 3 3 0 01-3 3H9a3 3 0 01-3-3z"></path>
                                </svg>
                            </button>
                            <pre>$defaultText</pre>
                        </div>
                    </div>
"@
        }
        
        if ($toolContent["UNO"].Count -gt 0) {
            $unoText = ($toolContent["UNO"] -join "`n")
            
            # Check if there are multiple prompts with "Prompt #" markers
            if ($unoText -match 'Prompt #\d+') {
                # Split by Prompt markers and rebuild with bullets
                $prompts = $unoText -split '(?=Prompt #\d+)'
                $bulletedPrompts = @()
                $promptNumber = 1
                
                foreach ($prompt in $prompts) {
                    $prompt = $prompt.Trim()
                    if ($prompt) {
                        # Remove "Prompt #X" line
                        $prompt = $prompt -replace '^\s*Prompt #\d+\s*[\r\n]+', ''
                        $prompt = $prompt.Trim()
                        if ($prompt) {
                            $bulletedPrompts += "$promptNumber. $prompt"
                            $promptNumber++
                        }
                    }
                }
                
                $unoText = $bulletedPrompts -join "`n`n"
            }
            
            $unoText = $unoText -replace '<', '&lt;' -replace '>', '&gt;'
            
            if ($showHeaders) {
                $html += @"
                    <div class="tool-section uno">
                        <h4>UNO</h4>
                        <div class="prompt-container">
                            <button class="copy-btn" onclick="copyPrompt(this)" title="Copy to clipboard">
                                <svg class="copy-icon" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M8 3a1 1 0 011-1h2a1 1 0 110 2H9a1 1 0 01-1-1z"></path>
                                    <path d="M6 3a2 2 0 00-2 2v11a2 2 0 002 2h8a2 2 0 002-2V5a2 2 0 00-2-2 3 3 0 01-3 3H9a3 3 0 01-3-3z"></path>
                                </svg>
                            </button>
                            <pre>$unoText</pre>
                        </div>
                    </div>
"@
            } else {
                $html += @"
                    <div class="tool-section-single">
                        <div class="prompt-container">
                            <button class="copy-btn" onclick="copyPrompt(this)" title="Copy to clipboard">
                                <svg class="copy-icon" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M8 3a1 1 0 011-1h2a1 1 0 110 2H9a1 1 0 01-1-1z"></path>
                                    <path d="M6 3a2 2 0 00-2 2v11a2 2 0 002 2h8a2 2 0 002-2V5a2 2 0 00-2-2 3 3 0 01-3 3H9a3 3 0 01-3-3z"></path>
                                </svg>
                            </button>
                            <pre>$unoText</pre>
                        </div>
                    </div>
"@
            }
        }
        
        if ($toolContent["LOVABLE"].Count -gt 0) {
            $lovableText = ($toolContent["LOVABLE"] -join "`n")
            
            if ($lovableText -match 'Prompt #\d+') {
                $prompts = $lovableText -split '(?=Prompt #\d+)'
                $bulletedPrompts = @()
                $promptNumber = 1
                
                foreach ($prompt in $prompts) {
                    $prompt = $prompt.Trim()
                    if ($prompt) {
                        $prompt = $prompt -replace '^\s*Prompt #\d+\s*[\r\n]+', ''
                        $prompt = $prompt.Trim()
                        if ($prompt) {
                            $bulletedPrompts += "$promptNumber. $prompt"
                            $promptNumber++
                        }
                    }
                }
                
                $lovableText = $bulletedPrompts -join "`n`n"
            }
            
            $lovableText = $lovableText -replace '<', '&lt;' -replace '>', '&gt;'
            
            if ($showHeaders) {
                $html += @"
                    <div class="tool-section lovable">
                        <h4>LOVABLE</h4>
                        <div class="prompt-container">
                            <button class="copy-btn" onclick="copyPrompt(this)" title="Copy to clipboard">
                                <svg class="copy-icon" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M8 3a1 1 0 011-1h2a1 1 0 110 2H9a1 1 0 01-1-1z"></path>
                                    <path d="M6 3a2 2 0 00-2 2v11a2 2 0 002 2h8a2 2 0 002-2V5a2 2 0 00-2-2 3 3 0 01-3 3H9a3 3 0 01-3-3z"></path>
                                </svg>
                            </button>
                            <pre>$lovableText</pre>
                        </div>
                    </div>
"@
            } else {
                $html += @"
                    <div class="tool-section-single">
                        <div class="prompt-container">
                            <button class="copy-btn" onclick="copyPrompt(this)" title="Copy to clipboard">
                                <svg class="copy-icon" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M8 3a1 1 0 011-1h2a1 1 0 110 2H9a1 1 0 01-1-1z"></path>
                                    <path d="M6 3a2 2 0 00-2 2v11a2 2 0 002 2h8a2 2 0 002-2V5a2 2 0 00-2-2 3 3 0 01-3 3H9a3 3 0 01-3-3z"></path>
                                </svg>
                            </button>
                            <pre>$lovableText</pre>
                        </div>
                    </div>
"@
            }
        }
        
        if ($toolContent["DREAMFLOW"].Count -gt 0) {
            $dreamflowText = ($toolContent["DREAMFLOW"] -join "`n")
            
            if ($dreamflowText -match 'Prompt #\d+') {
                $prompts = $dreamflowText -split '(?=Prompt #\d+)'
                $bulletedPrompts = @()
                $promptNumber = 1
                
                foreach ($prompt in $prompts) {
                    $prompt = $prompt.Trim()
                    if ($prompt) {
                        $prompt = $prompt -replace '^\s*Prompt #\d+\s*[\r\n]+', ''
                        $prompt = $prompt.Trim()
                        if ($prompt) {
                            $bulletedPrompts += "$promptNumber. $prompt"
                            $promptNumber++
                        }
                    }
                }
                
                $dreamflowText = $bulletedPrompts -join "`n`n"
            }
            
            $dreamflowText = $dreamflowText -replace '<', '&lt;' -replace '>', '&gt;'
            
            if ($showHeaders) {
                $html += @"
                    <div class="tool-section dreamflow">
                        <h4>DREAMFLOW</h4>
                        <div class="prompt-container">
                            <button class="copy-btn" onclick="copyPrompt(this)" title="Copy to clipboard">
                                <svg class="copy-icon" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M8 3a1 1 0 011-1h2a1 1 0 110 2H9a1 1 0 01-1-1z"></path>
                                    <path d="M6 3a2 2 0 00-2 2v11a2 2 0 002 2h8a2 2 0 002-2V5a2 2 0 00-2-2 3 3 0 01-3 3H9a3 3 0 01-3-3z"></path>
                                </svg>
                            </button>
                            <pre>$dreamflowText</pre>
                        </div>
                    </div>
"@
            } else {
                $html += @"
                    <div class="tool-section-single">
                        <div class="prompt-container">
                            <button class="copy-btn" onclick="copyPrompt(this)" title="Copy to clipboard">
                                <svg class="copy-icon" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M8 3a1 1 0 011-1h2a1 1 0 110 2H9a1 1 0 01-1-1z"></path>
                                    <path d="M6 3a2 2 0 00-2 2v11a2 2 0 002 2h8a2 2 0 002-2V5a2 2 0 00-2-2 3 3 0 01-3 3H9a3 3 0 01-3-3z"></path>
                                </svg>
                            </button>
                            <pre>$dreamflowText</pre>
                        </div>
                    </div>
"@
            }
        }
        
        $html += @"
                </div>

"@
    }
    
    # Add inspiration images section if present
    if ($project.InspirationImages.Count -gt 0) {
        $html += @"
                <div class="inspiration-section">
                    <h3>Inspiration</h3>
"@
        
        foreach ($inspirationImage in $project.InspirationImages) {
            $html += @"
                    <img src="$($inspirationImage.RelativePath)" alt="$($inspirationImage.Name)" class="inspiration-image" onclick="openLightbox('$($inspirationImage.RelativePath)')">
"@
        }
        
        $html += @"
                </div>

"@
    }
    
    # Add performance data for this project
    $projectPerf = $performanceData | Where-Object { $_.Name -eq $project.Name }
    if ($projectPerf) {
        $pLovableCost = if ($projectPerf.LovableCredits -eq 0) { "" } else { [math]::Round($projectPerf.LovableCredits * 0.43, 2) }
        $pLovableCostPerPage = if ($projectPerf.LovableCredits -eq 0) { "" } else { [math]::Round(($projectPerf.LovableCredits * 0.43) / $projectPerf.LovablePages, 2) }
        $pDreamflowCost = if ($projectPerf.DreamflowCredits -eq 0) { "" } else { [math]::Round($projectPerf.DreamflowCredits * 0.18, 2) }
        $pDreamflowCostPerPage = if ($projectPerf.DreamflowCredits -eq 0) { "" } else { [math]::Round(($projectPerf.DreamflowCredits * 0.18) / $projectPerf.DreamflowPages, 2) }
        $pVibecodeCost = if ($projectPerf.VibecodeCredits -eq 0) { "" } else { $projectPerf.VibecodeCredits }
        $pVibecodeCostPerPage = if ($projectPerf.VibecodePages -gt 0 -and $projectPerf.VibecodeCredits -gt 0) { [math]::Round($projectPerf.VibecodeCredits / $projectPerf.VibecodePages, 2) } else { "" }
        $pBuilderCost = if ($projectPerf.BuilderCredits -eq 0) { "" } else { [math]::Round($projectPerf.BuilderCredits * 0.048, 2) }
        $pBuilderCostPerPage = if ($projectPerf.BuilderPages -gt 0 -and $projectPerf.BuilderCredits -gt 0) { [math]::Round(($projectPerf.BuilderCredits * 0.048) / $projectPerf.BuilderPages, 2) } else { "" }
        
        # Display values or empty for 0
        $antigravityTimeDisplay = if ($projectPerf.AntigravityTime -eq 0) { "" } else { $projectPerf.AntigravityTime }
        $unoVSCodeTimeDisplay = if ($projectPerf.UnoVSCodeTime -eq 0) { "" } else { $projectPerf.UnoVSCodeTime }
        $unoVSCodeMCPTimeDisplay = if ($projectPerf.UnoVSCodeMCPTime -eq 0) { "" } else { $projectPerf.UnoVSCodeMCPTime }
        $lovableTimeDisplay = if ($projectPerf.LovableTime -eq 0) { "" } else { $projectPerf.LovableTime }
        $lovableCreditsDisplay = if ($projectPerf.LovableCredits -eq 0) { "" } else { $projectPerf.LovableCredits }
        $dreamflowTimeDisplay = if ($projectPerf.DreamflowTime -eq 0) { "" } else { $projectPerf.DreamflowTime }
        $dreamflowCreditsDisplay = if ($projectPerf.DreamflowCredits -eq 0) { "" } else { $projectPerf.DreamflowCredits }
        $vibecodeTimeDisplay = if ($projectPerf.VibecodeTime -eq 0) { "" } else { $projectPerf.VibecodeTime }
        $builderTimeDisplay = if ($projectPerf.BuilderTime -eq 0) { "" } else { $projectPerf.BuilderTime }
        $builderCreditsDisplay = if ($projectPerf.BuilderCredits -eq 0) { "" } else { $projectPerf.BuilderCredits }
        $boltTimeDisplay = if ($projectPerf.BoltTime -eq 0) { "" } else { $projectPerf.BoltTime }
        $boltTokensDisplay = if ($projectPerf.BoltTokens -eq 0) { "" } else { [math]::Round($projectPerf.BoltTokens / 1000, 0).ToString() + "k" }
        $pBoltCost = if ($projectPerf.BoltTokens -eq 0) { "" } else { [math]::Round($projectPerf.BoltTokens * 0.0000025, 2) }
        $pBoltCostPerPage = if ($projectPerf.BoltPages -gt 0 -and $projectPerf.BoltTokens -gt 0) { [math]::Round(($projectPerf.BoltTokens * 0.0000025) / $projectPerf.BoltPages, 2) } else { "" }
        $pTempoCost = if ($projectPerf.TempoCredits -eq 0) { "" } else { [math]::Round($projectPerf.TempoCredits * 0.20, 2) }
        $pTempoCostPerPage = if ($projectPerf.TempoPages -gt 0 -and $projectPerf.TempoCredits -gt 0) { [math]::Round(($projectPerf.TempoCredits * 0.20) / $projectPerf.TempoPages, 2) } else { "" }
        $tempoTimeDisplay = if ($projectPerf.TempoTime -eq 0) { "" } else { $projectPerf.TempoTime }
        $tempoCreditsDisplay = if ($projectPerf.TempoCredits -eq 0) { "" } else { $projectPerf.TempoCredits }
        
        $html += @"
                <div class="prompts-section">
                    <h3>Performance</h3>
                    <table class="summary-table">
                        <thead>
                            <tr>
                                <th>Tool</th>
                                <th>Time (s)</th>
                                <th>Credits</th>
                                <th>Tokens</th>
                                <th>Cost ($)</th>
                                <th>Cost/Page ($)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Antigravity</td>
                                <td>$antigravityTimeDisplay</td>
                                <td>-</td>
                                <td>-</td>
                                <td>-</td>
                                <td>-</td>
                            </tr>
                            <tr>
                                <td>Bolt</td>
                                <td>$boltTimeDisplay</td>
                                <td>-</td>
                                <td>$boltTokensDisplay</td>
                                <td>$pBoltCost</td>
                                <td>$pBoltCostPerPage</td>
                            </tr>
                            <tr>
                                <td>Builder</td>
                                <td>$builderTimeDisplay</td>
                                <td>$builderCreditsDisplay</td>
                                <td>-</td>
                                <td>$pBuilderCost</td>
                                <td>$pBuilderCostPerPage</td>
                            </tr>
                            <tr>
                                <td>Dreamflow</td>
                                <td>$dreamflowTimeDisplay</td>
                                <td>$dreamflowCreditsDisplay</td>
                                <td>-</td>
                                <td>$pDreamflowCost</td>
                                <td>$pDreamflowCostPerPage</td>
                            </tr>
                            <tr>
                                <td>Lovable</td>
                                <td>$lovableTimeDisplay</td>
                                <td>$lovableCreditsDisplay</td>
                                <td>-</td>
                                <td>$pLovableCost</td>
                                <td>$pLovableCostPerPage</td>
                            </tr>
                            <tr>
                                <td>Tempo</td>
                                <td>$tempoTimeDisplay</td>
                                <td>$tempoCreditsDisplay</td>
                                <td>-</td>
                                <td>$pTempoCost</td>
                                <td>$pTempoCostPerPage</td>
                            </tr>
                            <tr>
                                <td>Uno VS Code</td>
                                <td>$unoVSCodeTimeDisplay</td>
                                <td>-</td>
                                <td>-</td>
                                <td>-</td>
                                <td>-</td>
                            </tr>
                            <tr>
                                <td>Uno VS Code MCP</td>
                                <td>$unoVSCodeMCPTimeDisplay</td>
                                <td>-</td>
                                <td>-</td>
                                <td>-</td>
                                <td>-</td>
                            </tr>
                            <tr>
                                <td>Vibecode</td>
                                <td>$vibecodeTimeDisplay</td>
                                <td>-</td>
                                <td>-</td>
                                <td>$pVibecodeCost</td>
                                <td>$pVibecodeCostPerPage</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

"@
    }
    
    # Add tabs
    $html += @"
                <div class="tabs">
                    <button class="tab-button active" onclick="filterImages('$projectId', 'all')">All</button>
                    <button class="tab-button tab-antigravity" onclick="filterImages('$projectId', 'antigravity')">Antigravity</button>
                    <button class="tab-button tab-bolt" onclick="filterImages('$projectId', 'bolt')">Bolt</button>
                    <button class="tab-button tab-builder" onclick="filterImages('$projectId', 'builder')">Builder</button>
                    <button class="tab-button tab-dreamflow" onclick="filterImages('$projectId', 'dreamflow')">Dreamflow</button>
                    <button class="tab-button tab-lovable" onclick="filterImages('$projectId', 'lovable')">Lovable</button>
                    <button class="tab-button tab-tempo" onclick="filterImages('$projectId', 'tempo')">Tempo</button>
                    <button class="tab-button tab-uno" onclick="filterImages('$projectId', 'uno')">Uno HD</button>
                    <button class="tab-button tab-vscodeuno" onclick="filterImages('$projectId', 'vscodeuno')">Uno VS Code</button>
                    <button class="tab-button tab-vscodeunomcp" onclick="filterImages('$projectId', 'vscodeunomcp')">Uno VS Code MCP</button>
                    <button class="tab-button tab-vibecode" onclick="filterImages('$projectId', 'vibecode')">Vibecode</button>
                </div>

                <div class="images-grid" id="${projectId}_images">
"@
    
    # Group images by tool
    $imagesByTool = @{
        "antigravity" = @()
        "uno" = @()
        "vscodeuno" = @()
        "vscodeunomcp" = @()
        "lovable" = @()
        "dreamflow" = @()
        "vibecode" = @()
        "builder" = @()
        "bolt" = @()
        "tempo" = @()
        "other" = @()
    }
    
    foreach ($image in $project.Images) {
        $imagesByTool[$image.Tool] += $image
    }
    
    # Generate tool sections
    $toolOrder = @("antigravity", "bolt", "builder", "dreamflow", "lovable", "tempo", "uno", "vscodeuno", "vscodeunomcp", "vibecode", "other")
    foreach ($toolName in $toolOrder) {
        $toolImages = $imagesByTool[$toolName]
        if ($toolImages.Count -gt 0 -or ($toolName -eq "vibecode" -and $project.VibecodeVideoUrl) -or ($toolName -eq "builder" -and $project.BuilderVideoUrl) -or ($toolName -eq "bolt" -and $project.BoltVideoUrl) -or ($toolName -eq "tempo" -and $project.TempoVideoUrl)) {
            $toolDisplayName = switch ($toolName) {
                "antigravity" { "ANTIGRAVITY" }
                "uno" { "UNO HD" }
                "vscodeuno" { "UNO VS CODE" }
                "vscodeunomcp" { "UNO VS CODE MCP" }
                "lovable" { "LOVABLE" }
                "dreamflow" { "DREAMFLOW" }
                "vibecode" { "VIBECODE" }
                "builder" { "BUILDER" }
                "bolt" { "BOLT" }
                "tempo" { "TEMPO" }
                default { $toolName.ToUpper() }
            }
            
            $html += @"
                    <div class="tool-group" data-tool-group="$toolName">
                        <div class="tool-group-header $toolName">$toolDisplayName</div>
                        <div class="tool-group-images">
"@
            
            # Add video embed for Vibecode if URL exists
            if ($toolName -eq "vibecode" -and $project.VibecodeVideoUrl) {
                # Convert Google Drive view URL to embed URL
                $embedUrl = $project.VibecodeVideoUrl -replace '/view\?usp=drive_link', '/preview'
                $html += @"
                            <div class="video-container">
                                <iframe src="$embedUrl" width="640" height="480" allow="autoplay" allowfullscreen></iframe>
                            </div>
"@
            }
            
            # Add video embed for Builder if URL exists
            if ($toolName -eq "builder" -and $project.BuilderVideoUrl) {
                # Convert Google Drive view URL to embed URL
                $embedUrl = $project.BuilderVideoUrl -replace '/view\?usp=drive_link', '/preview'
                $html += @"
                            <div class="video-container">
                                <iframe src="$embedUrl" width="640" height="480" allow="autoplay" allowfullscreen></iframe>
                            </div>
"@
            }
            
            # Add video embed for Bolt if URL exists
            if ($toolName -eq "bolt" -and $project.BoltVideoUrl) {
                # Convert Google Drive view URL to embed URL
                $embedUrl = $project.BoltVideoUrl -replace '/view\?usp=drive_link', '/preview'
                $html += @"
                            <div class="video-container">
                                <iframe src="$embedUrl" width="640" height="480" allow="autoplay" allowfullscreen></iframe>
                            </div>
"@
            }
            
            # Add video embed for Tempo if URL exists
            if ($toolName -eq "tempo" -and $project.TempoVideoUrl) {
                # Convert Google Drive view URL to embed URL
                $embedUrl = $project.TempoVideoUrl -replace '/view\?usp=drive_link', '/preview'
                $html += @"
                            <div class="video-container">
                                <iframe src="$embedUrl" width="640" height="480" allow="autoplay" allowfullscreen></iframe>
                            </div>
"@
            }
            
            foreach ($image in $toolImages) {
                $materialBadge = ""
                if ($image.Name -match "Material") {
                    $materialBadge = "<div class='material-badge'>Material</div>"
                }
                
                $html += @"
                            <div class="image-card" data-tool="$($image.Tool)">
                                $materialBadge
                                <img src="$($image.RelativePath)" alt="$($image.Label)" onclick="openLightbox('$($image.RelativePath)', '$($image.Label)')">
                                <div class="image-label $($image.Tool)">$($image.Label)</div>
                            </div>
"@
            }
            
            $html += @"
                        </div>
                    </div>
"@
        }
    }
    
    $html += @"
                </div>
            </div>

"@
}

$html += @"
        </main>
    </div>

    <div id="lightbox" class="lightbox" onclick="closeLightbox(event)">
        <span class="lightbox-close" onclick="closeLightbox(event)">&times;</span>
        <span class="lightbox-arrow lightbox-arrow-left" id="lightbox-prev" onclick="navigateLightbox(event, -1)">&#8249;</span>
        <img class="lightbox-content" id="lightbox-img" onclick="event.stopPropagation()">
        <span class="lightbox-arrow lightbox-arrow-right" id="lightbox-next" onclick="navigateLightbox(event, 1)">&#8250;</span>
        <div class="lightbox-caption" id="lightbox-caption"></div>
    </div>

    <script>
        let currentImageIndex = -1;
        let visibleImages = [];

        function downloadCSV() {
            const table = document.getElementById('performance-table');
            let csv = [];
            
            // Get headers
            const headers = [];
            table.querySelectorAll('thead th').forEach(th => {
                headers.push('"' + th.innerText.replace(/\n/g, ' ').replace(/"/g, '""') + '"');
            });
            csv.push(headers.join(','));
            
            // Get rows
            table.querySelectorAll('tbody tr').forEach(tr => {
                const row = [];
                tr.querySelectorAll('td').forEach(td => {
                    row.push('"' + td.innerText.replace(/"/g, '""') + '"');
                });
                csv.push(row.join(','));
            });
            
            // Create download
            const csvContent = csv.join('\n');
            const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
            const link = document.createElement('a');
            const url = URL.createObjectURL(blob);
            link.setAttribute('href', url);
            link.setAttribute('download', 'performance-summary.csv');
            link.style.visibility = 'hidden';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }

        function showProject(projectId) {
            document.querySelectorAll('.project-section').forEach(section => {
                section.classList.remove('active');
            });
            document.getElementById(projectId).classList.add('active');
            
            document.querySelectorAll('.project-list li').forEach(li => {
                li.classList.remove('active');
                if (li.dataset.project === projectId) {
                    li.classList.add('active');
                }
            });
            
            // Scroll to container (past header)
            const container = document.querySelector('.container');
            if (container) {
                container.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
            
            updateVisibleImages();
        }

        function filterImages(projectId, tool) {
            const container = document.getElementById(projectId + '_images');
            const toolGroups = container.querySelectorAll('.tool-group');
            
            toolGroups.forEach(group => {
                if (tool === 'all' || group.dataset.toolGroup === tool) {
                    group.style.display = 'block';
                } else {
                    group.style.display = 'none';
                }
            });
            
            const section = document.getElementById(projectId);
            section.querySelectorAll('.tab-button').forEach(btn => {
                btn.classList.remove('active');
                btn.classList.remove('active-tool');
            });
            event.target.classList.add('active');
            if (tool !== 'all') {
                event.target.classList.add('active-tool');
            }
            
            updateVisibleImages();
        }

        function updateVisibleImages() {
            const activeSection = document.querySelector('.project-section.active');
            if (!activeSection) return;
            
            const container = activeSection.querySelector('.images-grid');
            const cards = container.querySelectorAll('.image-card');
            
            visibleImages = [];
            cards.forEach(card => {
                if (card.style.display !== 'none') {
                    const img = card.querySelector('img');
                    visibleImages.push({
                        src: img.src,
                        caption: img.alt
                    });
                }
            });
        }

        function openLightbox(src, caption) {
            updateVisibleImages();
            
            currentImageIndex = visibleImages.findIndex(img => img.src.endsWith(src));
            
            document.getElementById('lightbox').style.display = 'block';
            document.getElementById('lightbox-img').src = src;
            document.getElementById('lightbox-caption').textContent = caption;
            
            updateArrows();
        }

        function updateArrows() {
            const prevBtn = document.getElementById('lightbox-prev');
            const nextBtn = document.getElementById('lightbox-next');
            
            if (currentImageIndex <= 0 || visibleImages.length <= 1) {
                prevBtn.classList.add('disabled');
            } else {
                prevBtn.classList.remove('disabled');
            }
            
            if (currentImageIndex >= visibleImages.length - 1 || visibleImages.length <= 1) {
                nextBtn.classList.add('disabled');
            } else {
                nextBtn.classList.remove('disabled');
            }
        }

        function navigateLightbox(event, direction) {
            event.stopPropagation();
            
            const newIndex = currentImageIndex + direction;
            
            if (newIndex < 0 || newIndex >= visibleImages.length) {
                return;
            }
            
            currentImageIndex = newIndex;
            const image = visibleImages[currentImageIndex];
            
            document.getElementById('lightbox-img').src = image.src;
            document.getElementById('lightbox-caption').textContent = image.caption;
            
            updateArrows();
        }

        function closeLightbox(event) {
            if (event) {
                event.stopPropagation();
            }
            document.getElementById('lightbox').style.display = 'none';
        }

        document.addEventListener('keydown', (e) => {
            const lightbox = document.getElementById('lightbox');
            if (lightbox.style.display === 'block') {
                if (e.key === 'Escape') {
                    closeLightbox();
                } else if (e.key === 'ArrowLeft') {
                    navigateLightbox(e, -1);
                } else if (e.key === 'ArrowRight') {
                    navigateLightbox(e, 1);
                }
            }
        });

        document.querySelectorAll('.project-list li').forEach(li => {
            li.addEventListener('click', () => {
                showProject(li.dataset.project);
            });
        });
        
        window.addEventListener('load', () => {
            updateVisibleImages();
        });

        function switchTableView(view) {
            // Remove view-active from all columns
            document.querySelectorAll('#performance-table th[data-view], #performance-table td[data-view]').forEach(cell => {
                cell.classList.remove('view-active');
            });
            
            // Add view-active to columns matching the view
            document.querySelectorAll('#performance-table th[data-view="' + view + '"], #performance-table td[data-view="' + view + '"]').forEach(cell => {
                cell.classList.add('view-active');
            });
            
            // Update button states
            document.querySelectorAll('.view-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');
        }

        function copyPrompt(button) {
            const container = button.closest('.prompt-container');
            const pre = container.querySelector('pre');
            const text = pre.textContent;
            
            navigator.clipboard.writeText(text).then(() => {
                const originalText = button.innerHTML;
                button.innerHTML = '<svg class="copy-icon" fill="currentColor" viewBox="0 0 20 20"><path d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"></path></svg>';
                button.classList.add('copied');
                
                setTimeout(() => {
                    button.innerHTML = originalText;
                    button.classList.remove('copied');
                }, 2000);
            }).catch(err => {
                console.error('Failed to copy:', err);
                alert('Failed to copy to clipboard');
            });
        }
    </script>
</body>
</html>
"@

# Write the HTML file
$html | Out-File -FilePath $outputFile -Encoding UTF8
Write-Host "`nGenerated: $outputFile"
Write-Host "Total projects: $($projectsData.Count)"
