FUNCTION_BLOCK FB_ST_PAZ_SKV_KOS_KORVET
IF CRXX_SERVER OR CRXX_PANEL OR CRXX_RESERV OR NONOPE THEN
    TON4.IN:=FALSE;
    TON3.IN:=FALSE;
    TON2.IN:=FALSE;
    TON1.IN:=FALSE;
    ZAPUSKPROM:=FALSE;
    ZAPON:=FALSE;
    OSTANOV:=FALSE;
    XPFF:=FALSE;
    BZ_CEOF:=FALSE;
    SZ_CEOF:=FALSE;
    UDK_CEXX:=FALSE;
    PAZ:=FALSE;
    SHZ_CAOF:=FALSE;
    K1_CAOF:=FALSE;
    K2_CAOF:=FALSE;
    ABDI_CENX:=FALSE;
    ABDI_CEXX:=FALSE;
    UDK_CENX:=FALSE;
    SHZ_CEOF:=FALSE;
    BZ_CAOF:=FALSE;
    SZ_CAOF:=FALSE;
    AVAR_IOFX_IVXX:=FALSE;
    START_TIMER:=FALSE;
    CONFIRM_PANEL:=FALSE;
    CONFIRM_SERVER:=FALSE;
    CONFIRM_RESERV:=FALSE;
    ZAPUSK_SERVER:=FALSE;
    ZAPUSK_PANEL:=FALSE;
    ZAPUSK_RESERV:=FALSE;
    AO_ASU_RESERV:=FALSE;
    AO_ASU_PANEL:=FALSE;
    AO_ASU_SERVER:=FALSE;
    K1_CEOF:=FALSE;
    K2_CEOF:=FALSE;
    OSTANOV_ALG:=FALSE;
    PAZ_ALG:=FALSE;
    NONOPE:=FALSE;
    AVAR:=FALSE;
    XPFX:=FALSE;
    MANUAL:=FALSE;
    END_IF; 

(*инициализвация запуска НО*)
IF ZAPUSK_SERVER OR ZAPUSK_PANEL OR ZAPUSK_RESERV THEN
    ZAPUSKPROM:=TRUE;
    END_IF;


IF STOP_PANEL OR STOP_RESERV OR STOP_SERVER THEN
    ZAPUSK_SERVER:=FALSE;
    ZAPUSK_PANEL:=FALSE;
    ZAPUSK_RESERV:=FALSE;
    ZAPUSKPROM:=FALSE;
    END_IF;

IF NOT ZAPUSKPROM THEN
    STOP_PANEL:=FALSE;
    STOP_SERVER:=FALSE;
    STOP_RESERV:=FALSE;
    END_IF;

TON1 (.IN, .PT);
TON1.PT:=T#30s;
TON1.IN:=ZAPUSKPROM;
IF TON1.Q THEN
    ZAPON:=TRUE;      (*СБРОС ОБЩЕГО ЗАПУСКА*)
    END_IF;

(*ЗАПУСК ТАЙМЕРА ОБРАТНОГО ОТЧЕТА ВРЕМЕНИ ЗАПУСКА НО*)
TCYCLE:= ANY_TO_REAL(__SYSVA_TCYCYCTIME)/1000;
IF ZAPUSKPROM AND NOT XPFX1 AND NOT XPFX2 THEN
TIMER2:=TIMER2+TCYCLE;
ELSE
TIMER2:=0;
END_IF;

XTCX2:=30-TIMER2;

IF CONFIRM_PANEL OR CONFIRM_SERVER OR CONFIRM_RESERV OR NO_KGS THEN
    ZAPON:=TRUE; 
    END_IF;

IF ZAPON AND ZAPUSK_SERVER THEN
    ZP_SERVER:=TRUE;
    ELSE
    ZP_SERVER:=FALSE;
    END_IF;

IF ZAPON AND ZAPUSK_PANEL THEN
    ZP_PANEL:=TRUE;
    ELSE
    ZP_PANEL:=FALSE;
    END_IF;

IF ZAPON AND ZAPUSK_RESERV THEN
    ZP_RESERV:=TRUE;
    ELSE
    ZP_RESERV:=FALSE;
    END_IF;   

IF ZAPON AND (SHZ_ILCX OR SHZ_FXXX OR BZI_LCX OR BZ_FXXX OR SZ_ILCX OR SZ_FXXX OR K1_ILCX OR K1_FXXX OR 
K2_ILCX OR K2_FXXX OR UDK_XRCX OR UDK_FXXX OR SHZ_CRPX OR SZ_CRPX OR BZ_CRPX OR K1_CRPX OR K2_CRPX
OR UDK_CRPX OR ABDI_CRPX) AND NOT OSTANOV THEN
    NONOPE:=TRUE;
    END_IF;  

IF NOT SHZ_ILCX AND NOT SHZ_FXXX AND NOT BZI_LCX AND NOT BZ_FXXX AND
NOT SZ_ILCX AND NOT SZ_FXXX AND NOT K1_ILCX AND NOT K1_FXXX AND NOT K2_ILCX AND NOT K2_FXXX AND
NOT UDK_XRCX AND NOT UDK_FXXX AND NOT SHZ_CRPX AND NOT SZ_CRPX AND NOT BZ_CRPX AND NOT K1_CRPX
AND NOT K2_CRPX AND NOT UDK_CRPX AND NOT ABDI_CRPX THEN
    RDY:=TRUE;
    ELSE
    RDY:=FALSE;
    END_IF;
IF ZAPON AND RDY THEN
    NOYEP:=TRUE;
    ELSE
    NOYEP:=FALSE;
    END_IF;

(*ПРОВЕРКА АВАРИЙНЫХ СОСТОЯНИЙ ПО СКВАЖИНЕ, ФОРМИРОВАНИЕ КОМАНДЫ АВАРИЙНОГО ОСТАНОВА*)

IF (P1_XLAX OR P2_XLAX) OR ((P_ABDI_XLAX OR P_ABDI_XHAX) AND (NOT K1_XOFX AND NOT K2_XOFX)) 
OR AVAR_CLD_OXON THEN
    AO_SKV:=TRUE;
    ELSE
    AO_SKV:=FALSE;
    END_IF;

(*ЗПУСК АЛГОРИТМА ОСТАНОВА (НО,ВО,АО) В ЗАВИСИМОСТИ ОТ ИНИЦИАТОРА*)
IF NOYEP THEN
    OSTANOV:=TRUE;
END_IF;

IF PUSK_BLOCK_SERVER OR PUSK_BLOCK_RESERV OR PUSK_BLOCK THEN
    BLOCK_PAZ:=TRUE;
    PUSK_BLOCK_RESERV:=FALSE;
    PUSK_BLOCK:=FALSE;
    PUSK_BLOCK_SERVER:=FALSE;
    END_IF;

(*Подтверждение запуска*)
IF MANUAL_SERVER OR MANUAL_PANEL OR MANUAL_RESERV THEN
    MANUAL:=TRUE;
    MANUAL_SERVER:=FALSE;
    MANUAL_PANEL:=FALSE;
    MANUAL_RESERV:=FALSE;
    END_IF;
    

IF PUSK_UNBLOCK_RESERV OR PUSK_UNBLOCK_SERVER OR PUSK_UNBLOCK_PANEL THEN
    BLOCK_PAZ:=FALSE;
    PUSK_UNBLOCK_RESERV:=FALSE;
    PUSK_UNBLOCK_PANEL:=FALSE;
    PUSK_UNBLOCK_SERVER:=FALSE;
    END_IF;

IF ((VO_KGS OR VO_ASU OR AO_ASU OR AO_KGS OR AO_SKV) AND NOT TYPE_USO) AND NOT BLOCK_PAZ  THEN
    OSTANOV:=TRUE;
    PAZ:=TRUE;
    PAZ_ALG:=TRUE;
    AVAR:=TRUE;
    END_IF;

IF (AO_ASU_SERVER OR AO_ASU_PANEL OR AO_ASU_RESERV) AND NOT TYPE_USO THEN
    OSTANOV:=TRUE;
    PAZ:=TRUE;
    PAZ_ALG:=TRUE;
    END_IF;

IF ((VO_KGS OR VO_ASU OR AO_ASU OR AO_KGS OR AO_SKV)  AND TYPE_USO) AND NOT BLOCK_PAZ THEN
    OSTANOV:=TRUE;
    AVAR_IOFX_IVXX:=TRUE;
    PAZ_ALG:=TRUE;
    AVAR:=TRUE;
    END_IF;

IF (AO_ASU_RESERV OR AO_ASU_SERVER OR AO_ASU_PANEL)  AND TYPE_USO THEN
    OSTANOV:=TRUE;
    AVAR_IOFX_IVXX:=TRUE;
    PAZ_ALG:=TRUE;
    END_IF;


IF OSTANOV THEN
    OSTANOV_ALG:=TRUE;
    END_IF;
IF OSTANOV AND NOT XPFX THEN
  START_TIMER:=TRUE;
    END_IF;


(*ЗАПУСК ТАЙМЕРА ОБРАТНОГО ОТЧЕТА ВРЕМЕНИ ОСТАНОВА*)
IF START_TIMER THEN
    TIMER1:=TIMER1+TCYCLE;
    IF TIMER1>STPX THEN
        XPFF:=TRUE; (*АЛГОРИТМ НЕ ОТРАБОТАЛ*)
        END_IF;    
    ELSE
    TIMER1:=0;
    END_IF;
IF OSTANOV AND NOT PAZ_ALG AND XPFF THEN
    XPFF1:=TRUE;  (*НОРМАЛЬНЫЙ ОСТАНОВ НЕ ВЫПОЛНЕН В ЖУРНАЛ*)
    ELSE
    XPFF1:=FALSE;
    END_IF;
IF PAZ_ALG AND XPFF THEN
    XPFF2:=TRUE; (*ПАЗ НЕ ОТРАБОТАЛ*)
    ELSE
    XPFF2:=FALSE;
    END_IF;

XTCX:=STPX-TIMER1;

(*ВЫПОЛНЕНИЕ АЛГОРИТМА *)

IF OSTANOV OR PAZ THEN
    SHZ_CAOF:=TRUE;
    END_IF;

IF OSTANOV AND P_ABDI_XHAX THEN
    K1_CAOF:=TRUE;
    K2_CAOF:=TRUE;
    END_IF;
  
TON2 (.IN, .PT);
TON2.PT:=T#5s;
IF OSTANOV THEN
TON2.IN:=TRUE;
ELSE
TON2.IN:=FALSE;
END_IF;

IF TON2.Q AND NOT SHZ_XONX AND NOT PAZ THEN (*НОРМАЛЬНЫЙ*)
    K1_CAOF:=TRUE;
    K2_CAOF:=TRUE;
    ABDI_CENX:=TRUE;
    END_IF;
IF TON2.Q AND NOT SHZ_XONX AND PAZ THEN (*АВАРИЙНЫЙ*)
    K1_CEOF:=TRUE;
    K2_CEOF:=TRUE;
    ABDI_CEXX:=TRUE;
    END_IF;

(*ВЕТКА НО, ВО, АО СБРОСИТЬ ПЕРМЕННЫЕ!*)

IF OSTANOV AND SHZ_XOFX THEN
    SHZ_CAOF:=FALSE;
    BZ_CAOF:=TRUE;
    END_IF;

IF OSTANOV AND BZ_XOFX AND SHZ_XOFX THEN
    BZ_CAOF:=FALSE;
    SZ_CAOF:=TRUE;
    END_IF;

IF OSTANOV AND SZ_XOFX AND SHZ_XOFX AND BZ_XOFX THEN
    SZ_CAOF:=FALSE;
    UDK_CENX:=TRUE;
    END_IF;

(*ВЕТКА ВО И АО*)

TON3 (.IN, .PT);
TON3.PT:=T#1m;
IF PAZ THEN
TON3.IN:=TRUE;
ELSE
TON3.IN:=FALSE;
    END_IF;
IF TON3.Q AND NOT SHZ_XOFX THEN
    SHZ_CEOF:=TRUE;
    BZ_CEOF:=TRUE;
    END_IF;


TON4 (.IN, .PT);
TON4.PT:=T#1m;
IF BZ_CEOF OR BZ_CAOF AND PAZ THEN
TON4.IN:=TRUE;
ELSE
TON4.IN:=FALSE;
END_IF;
IF TON4.Q AND NOT BZ_XOFX THEN
    SZ_CEOF:=TRUE;
    UDK_CEXX:=TRUE;
    END_IF;

(*ЗАВЕРШЕНИЕ РАБОТЫ АЛГОРИТМА*)
IF OSTANOV AND (SHZ_XOFX OR SHZ_CRPX) AND (SZ_XOFX OR SZ_CRPX) AND (BZ_XOFX OR BZ_CRPX)
 AND (K1_XOFX OR K1_CRPX) AND (K2_XOFX OR K2_CRPX) AND (UDK_XOFX OR UDK_CRPX) AND (ABDI_XOFX OR ABDI_CRPX) AND NOT XPFF THEN
    XPFX:=TRUE;
    START_TIMER:=FALSE;
    END_IF;

IF XPFX AND PAZ_ALG THEN
    XPFX2:=TRUE;
    ELSE
    XPFX2:=FALSE;
    END_IF;

IF XPFX AND NOT PAZ_ALG THEN
    XPFX1:=TRUE;
    ELSE
    XPFX1:=FALSE;
    END_IF;

IF CRXX_SERVER OR CRXX_RESERV OR CRXX_PANEL THEN
    CRXX_SERVER:=FALSE;
    CRXX_PANEL:=FALSE;
    CRXX_RESERV:=FALSE;
    END_IF;

  
END_FUNCTION_BLOCK
