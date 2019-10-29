FUNCTION_BLOCK FB_ST_UDK_2
(*ХОЛДИНГ РЕГИСТР ВХОДНЫХ КАНАЛОВ ДЛЯ ПАНЕЛЕЙ ЕБАНЫХ*)

(*проверка отсутствия предельных положений по КГС*)
IF QKGSXHWX<QKGSXVXX OR QKGSXLWX>QKGSXVXX OR PKGSXHWX<PKGSXVXX OR PKGSXLWX>PKGSXVXX OR PAZ OR QKGSIFXX OR PKGSIFXX THEN
    KGSOFF :=TRUE;
	ELSE
	KGSOFF :=FALSE;
    END_IF;
IF KGSOFF THEN
    FP :=FALSE;
    FQP :=FALSE;
    END_IF;
    
IF KGSOFF THEN
    COMM := TRUE;
    END_IF;

IF OSTANOV THEN
    COMM:=TRUE;
    END_IF;
(*СТАБИЛИЗАЦИЯ РАСХОДА*)
TON1 (.IN, .PT);
TON1.PT:=timer1;
IF RS1 OR RS2 OR RS3 THEN
    TON1.IN:=FALSE;
    END_IF;
IF QKGSTH <> QKGST THEN
    TON1.IN := FALSE;
    END_IF;
IF FQP THEN
    TON1.IN:= TRUE;
    ELSE
    TON1.IN:=FALSE;
    END_IF;
IF TON1.Q AND (ABS(QKGSXVXX-QKGSTH))<=BETA THEN
    STAB1:=TRUE;
    END_IF;
IF TON1.Q AND (ABS(QKGSXVXX-QKGSTH))>BETA THEN
    NSTAB1:=TRUE;
    END_IF;
IF STAB1 OR NSTAB1 THEN
    STAB1:=FALSE;
    NSTAB1:=FALSE;
    END_IF;
(*стабилизакция давления е бой еееееееее бой*)
TON2 (.IN, .PT);
TON2.PT:=timer1;
IF RS1 OR RS2 OR RS3 THEN
    TON2.IN:=FALSE;
    END_IF;
IF PKGSTH <> PKGST THEN
    TON2.IN := FALSE;
    END_IF;
IF FP11 THEN FP:=TRUE; END_IF;
IF FP THEN
    TON2.IN:= TRUE;
    ELSE
    TON2.IN:=FALSE;
    END_IF;
IF TON2.Q AND (ABS(PKGST-P1SHWX-P2SHWX-P3SHWX-P4SHWX-P5SHWX-P6SHWX-P7SHWX))<=DELTA THEN
    PSTAB:=TRUE;
    END_IF;
IF TON2.Q AND (ABS(PKGST-P1SHWX-P2SHWX-P3SHWX-P4SHWX-P5SHWX-P6SHWX-P7SHWX))>DELTA THEN
    PNSTAB:=TRUE;
    END_IF;
IF PSTAB OR PNSTAB THEN
    PSTAB:=FALSE;
    PNSTAB:=FALSE;
    END_IF;

(*--------------селектор режима работы, реализация переключений
-------------------------------------------------------------
-------------------------------------------------------------*)
(*РЕЖИМ РЕГУЛИРВОАНИЯ ПО ДАВЛЕНИЮ*)

IF RS1 THEN
    RS1 :=FALSE;
    END_IF;

IF FP AND NOT RS1H THEN
    RS1 :=TRUE;
    RS1H :=TRUE;
    END_IF;

IF NOT FP THEN
    RS1H :=FALSE;
    END_IF;


(*РЕЖИМ РЕГУЛИРОВАНИЯ ПО РАСХОДУ*)

IF RS2 THEN
    RS2 :=FALSE;
    END_IF;

IF FQP11 THEN FQP:=TRUE; END_IF;

IF FQP AND NOT RS2H THEN
    RS2 :=TRUE;
    RS2H :=TRUE;
    END_IF;

IF NOT FQP THEN
    RS2H :=FALSE;
    END_IF;

(*РЕЖИМ РУЧНОЙ*)

IF RS3 THEN
    RS3 :=FALSE;
    END_IF;
IF COMM11 THEN COMM:=TRUE; END_IF;
IF COMM AND NOT RS3H THEN
    RS3 :=TRUE;
    RS3H :=TRUE;
    END_IF; 
    
IF NOT COMM THEN
    RS3H :=FALSE;
    END_IF;

(*СБРОС РЕЖИМОВ ПРИ ПЕРЕКЛЮЧЕНИИ*)

IF RS2 OR RS3 THEN
    FP :=FALSE;
    END_IF;

IF RS1 OR RS3 THEN
    FQP :=FALSE;
    END_IF;

IF RS1 OR RS2 THEN
    COMM :=FALSE;
    END_IF;
    
IF NOT FP AND NOT FQP THEN
    COMM:=TRUE;
    END_IF;
    
    (*ПЕРЕВОД СКАВЖИН В РУЧНОЙ РЕЖИМ*)



(*ПЕРЕКЛЮЧЕНИЕ ПОДРЕЖИМОВ АВТОМАТИЧЕСКОГО РЕГУЛИРОВАНИЯ ПО РАСХОДУ*)

IF RSS1 THEN
    RSS1 :=FALSE;
    END_IF;
IF QR11 THEN QR1:=TRUE; END_IF;
IF QR1 AND NOT RSS1H THEN
    RSS1 :=TRUE;
    RSS1H :=TRUE;
    END_IF;
    
IF NOT QR1 THEN
    RSS1H :=FALSE;
    END_IF;
    
(*ВТОРОЙ РЕЖИМ*)

IF RSS2 THEN
    RSS2 :=FALSE;
    END_IF;
IF QR22 THEN QR2:=TRUE; END_IF;   
IF QR2 AND NOT RSS2H THEN
    RSS2 :=TRUE;
    RSS2H :=TRUE;
    END_IF;

IF NOT QR2 THEN
    RSS2H :=FALSE;
    END_IF;
    
(*ТРЕТИЙ РЕЖИМ*)

IF RSS3 THEN
    RSS3 :=FALSE;
    END_IF;
IF QR33 THEN QR3:=TRUE; END_IF;
IF QR3 AND NOT RSS3H THEN
    RSS3 :=TRUE;
    RSS3H :=TRUE;
    END_IF;
    
IF NOT QR3 THEN
    RSS3H :=FALSE;
    END_IF;
    
(*ЧЕТВЕРТЫЙ РЕЖИМ*)

IF RSS4 THEN
    RSS4 :=FALSE;
    END_IF;
IF QR44 THEN QR4:=TRUE; END_IF;   
IF QR4 AND NOT RSS4H THEN
    RSS4 :=TRUE;
    RSS4H :=TRUE;
    END_IF;
    
IF NOT QR4 THEN
    RSS4H :=FALSE;
    END_IF;
    
(*СБРОС РЕЖИМОВ ПРИ ПЕРЕКЛЮЧЕНИЙ*)

IF RSS2 OR RSS3 OR RSS4 THEN
    QR1 :=FALSE;
    END_IF;
    
IF RSS1 OR RSS3 OR RSS4 THEN
    QR2 :=FALSE;
    END_IF;
    
IF RSS1 OR RSS2 OR RSS4 THEN
    QR3 :=FALSE;
    END_IF;
    
IF RSS1 OR RSS2 OR RSS3 THEN
    QR4 :=FALSE;
    END_IF;

IF NOT QR2 AND NOT QR3 AND NOT QR4 THEN
    QR1:=TRUE;
    END_IF;
    
    
    
(*ЗАДАЧА ПАРАМЕТРОВ, ЗАПРЕТ ЗАДАЧИ НЕВЫПОЛНИМЫХ УСЛОВИЙ*)
IF PKGSXLWX > PKGST OR PKGSXHWX < PKGST THEN
    PKGST :=PKGSTH;
    END_IF;
    
IF PKGSXLWX < PKGST AND PKGSXHWX > PKGST THEN
    PKGSTH :=PKGST;
    END_IF;       
    
IF QKGSXLWX > QKGST OR QKGSXHWX < QKGST THEN
    QKGST :=QKGSTH;
    END_IF;

IF QKGSXLWX < QKGST OR QKGSXHWX > QKGST THEN
    QKGSTH :=QKGST;
    END_IF;

(*ДАВЛЕНИЕ ДЛЯ СКВАЖИН*)

PXVX := PKGSTH + EPSILON;

(*РАСЧЕТ РАСХОДА ДЛЯ СКВАЖИН В ПОДРЕЖИМЕ 4*)
IF NSKV>2 THEN
    X3 :=1;
    ELSE
    X3 :=0;
    END_IF;
    
IF NSKV >3 THEN
    X4 :=1;
    ELSE
    X4 :=0;
    END_IF;
    
IF NSKV >4 THEN
    X5 :=1;
    ELSE
    X5 :=0;
    END_IF;
    
IF NSKV >5 THEN
    X6 :=1;
    ELSE
    X6 :=0;
    END_IF;
    
IF NSKV >6 THEN
    X7 :=1;
    ELSE
    X7 :=0;
    END_IF;
    
 (*ЗАДАНИЕ НЕ ИСПРАВНЫХ СКВАЖИН*)       
IF P1DAPX OR Q1DAPX OR IFXX1 THEN
    Y1:=0;
    Z1:=1;
    ELSE
    Y1:=1;
    Z1:=0;
    END_IF;
    
IF P2DAPX OR Q2DAPX OR IFXX2 THEN
    Y2 :=0;
    Z2 :=1;
    ELSE
    Y2:=1;
    Z2:=0;
    END_IF;
    
IF P3DAPX OR Q3DAPX OR IFXX3 THEN
    Y3:=0;
    Z3:=1;
    ELSE
    Y3:=1;
    Z3:=0;
    END_IF;
    
IF P4DAPX OR Q4DAPX OR IFXX4 THEN
    Y4:=0;
    Z4:=1;
    ELSE
    Y4:=1;
    Y4:=0;
    END_IF;
    
IF P5DAPX OR Q5DAPX OR IFXX5 THEN
    Y5:=0;
    Z5:=1;
    ELSE
    Y5:=1;
    Z5:=0;
    END_IF;
    
IF P6DAPX OR Q6DAPX OR IFXX6 THEN
    Y6:=0;
    Z6:=1;
    ELSE
    Y6:=1;
    Z6:=0;
    END_IF;
    
IF P7DAPX OR Q7DAPX OR IFXX7 THEN
    Y7:=0;
    Z7:=1;
    ELSE
    Y7:=1;
    Z7:=0;
    END_IF;
    
QKGS4 :=((Q1SHWX*Y1)+(Q2SHWX*Y2)+(Q3SHWX*X3*Y3)+(Q4SHWX*X4*Y4)+(Q5SHWX*X5*Y5)+(Q6SHWX*X6*Y6)+(Q7SHWX*X7*Y7));

(*защита от нуля*)
IF QKGS4 = 0 THEN
        QKGS4:=1;
        END_IF;
        

QKGSTP:=QKGSTH - Q1XV*Z1-Q2XV*Z2-Q3XV*Z3*X3-Q4XV*Z4*X4-Q5XV*Z5*X5-Q6XV*Z6*X6-Q7XV*Z7*X7;

        
Q41:=(QKGSTP/QKGS4)*Q1SHWX;
Q42:=(QKGSTP/QKGS4)*Q2SHWX;
Q43:=(QKGSTP/QKGS4)*Q3SHWX;
Q44:=(QKGSTP/QKGS4)*Q4SHWX;
Q45:=(QKGSTP/QKGS4)*Q5SHWX;
Q46:=(QKGSTP/QKGS4)*Q6SHWX;
Q47:=(QKGSTP/QKGS4)*Q7SHWX;

(*уставки мертвой зоны*)
IF COMM OR FP THEN
    BETTA1:=DELTA;
    END_IF;
IF FQP THEN
    BETTA1:=BETA;
    DELTA1:=DELTA;
    END_IF;
(*сумма расходов*)

SUM1:=Q1SAPV1+Q2SAPV1+Q3SAPV1*X3+Q4SAPV1*X4+Q5SAPV*X5+Q6SAPV*X6+Q7SAPV1*X7; 

SUM2:=Q1SAPV2*0.01*Q1SHWX+Q2SAPV2*0.01*Q2SHWX+Q3SAPV2*0.01*Q3SHWX*X3+Q4SAPV2*0.01
*Q4SHWX*X4+Q6SAPV2*0.01*Q6SHWX*X6+Q5SAPV2*0.01*Q5SHWX*X5+Q7SAPV2*0.01*Q7SHWX*X7;

SUM3:=(((Q2SHWX-Q2SHLX)/100)*Q2SAPV3+Q2SHLX)+(((Q1SHWX-Q1SLWX)/100)*Q1SAPV3+Q1SLWX)+
(((Q3SHWX-Q3SHLX)/100)*Q3SAPV3+Q3SHLX)+(((Q4SHWX-Q4SHLX)/100)*Q4SAPV3+Q4SHLX)
+(((Q5SHWX-Q5SHLX)/100)*Q5SAPV3+Q5SHLX)+(((Q6SHWX-Q6SHLX)/100)*Q6SAPV3+Q6SHLX)
+(((Q7SHWX-Q7SHLX)/100)*Q7SAPV3+Q7SHLX);

SUM4:= Q41+Q42+Q43+Q44+Q45+Q46+Q47;

IF (ABS (SUM1-QKGSTH))> BETA THEN
    NSUM1:=TRUE;
    ELSE
    NSUM1:=FALSE;
    END_IF;

IF (ABS (SUM2-QKGSTH)) > BETA THEN
    NSUM2:=TRUE;
    ELSE
    NSUM2:=FALSE;
    END_IF;

IF (ABS (SUM3-QKGSTH)) > BETA THEN
    NSUM3:=TRUE;
    ELSE
    NSUM3:=FALSE;
    END_IF;

IF (ABS (SUM4 - QKGSTH)) > BETA THEN
    NSUM4:=TRUE;
    ELSE
    NSUM4:=FALSE;
    END_IF;

IF NOT NSUM1 THEN
    FQP:=FALSE;
    END_IF;



(*ПРИВЯЗКА СООБЩЕНИЯ ПЕРЕВОДА СКВАЖИНЫ В РУЧНОЙ РЕЖИМ ДЕЛАТЬ ПО ILCX!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
К QCOMM ПРИВЯЗАТЬ ОГОНЕК ВЫВЕДЕН ИЗ АЛГОРИТМА ПО БРАТСКИ*)
(*-=========================================================================-*)
                                 (*СКВАЖИНА 1*)
(*-=========================================================================-*)
(*ВЫВОД СКВАЖИНЫ ИЗ АЛГОРИТМА ПЕРЕВОД В РУЧНОЙ РЕЖИМ*)
IF ILCX11 THEN ILCX1:=TRUE; END_IF;
IF P1DAPX OR Q1DAPX OR (P1SHWX<P1XVXX) OR (P1SLWX>P1XVXX) OR (Q1SHWX<Q1XVXX) OR (Q1SLWX>Q1XVXX) OR ILCX1 OR IFXX1 THEN
    ILCX1 :=TRUE;
    Q1COMM :=TRUE;
    P1COMM :=TRUE;
    END_IF;

IF COMM THEN
    Q1COMM :=TRUE;
    P1COMM :=TRUE;
    END_IF;
    
IF NOT P1DAPX AND NOT Q1DAPX AND NOT IFXX1 THEN
    Q1XV:=Q1XVXX;
    END_IF;
    

(*ПРОВЕРКА МАКСИМАЛЬНЫХ ПОЛОЖЕНИЙ КЛАПАНА РЕГУЛЯТОРА*)

IF XCCP1>=SAPH1 THEN
    KLR1MS :=TRUE;
    ELSE
    KLR1MS :=FALSE;
    END_IF;
IF XCCP1<=SAPL1 THEN
    KLR1M :=TRUE;
    ELSE
    KLR1M :=FALSE;
    END_IF;

(*ЗАДАЧА ПАРАМЕТРОВ, ЗАПРЕТ ЗАДАЧИ НЕВЫПОЛНИМЫХ УСЛОВИЙ*)
(*ДАВЛЕНИЕ СКВАЖИНЫ ТРЕБУЕМОЕ*)
IF P1SSPL > PXVX THEN
    P1XVX :=P1SSPL;
    END_IF;
IF P1SSPH < PXVX THEN
    P1XVX :=P1SSPH;
    END_IF;
    
IF P1SSPL < PXVX AND P1SSPH > PXVX THEN
    P1XVX :=PXVX;
    END_IF; 


(*РАСХОД *)

IF QR1 THEN
    Q1XVX :=Q1SAPV1;
    END_IF;
IF QR2 THEN
    Q1XVX:=Q1SAPV2*0.01*Q1SHWX;
    END_IF;
IF QR3 THEN 
    Q1XVX :=((Q1SHWX-Q1SLWX)/100)*Q1SAPV3+Q1SLWX;
    END_IF;                            

IF QR4 THEN
    Q1XVX :=Q41;
    END_IF;
    
(*ЗАПРЕТ НЕ ВЫПОЛНИМЫХ УСЛОВИЙ*)   

IF Q1SSPL > Q1XVX THEN
    Q1XVX1 :=Q1SSPL;
    END_IF;
    
IF Q1SSPH < Q1XVX THEN
    Q1XVX1 :=Q1SSPH;
    END_IF;
    
IF Q1SSPL < Q1XVX AND Q1SSPH > Q1XVX THEN
    Q1XVX1 :=Q1XVX;
    END_IF;
    
    
(*СЕЛЕКТОР ОСНОВНОГО И КОРРЕКТИРУЮЩЕГО ПАРАМЕТРОВ*)

IF COMM OR FP THEN
    Q1DPX:=P1DAPX;
    Q1SWX :=P1SSPH;
    Q1SLX :=P1SSPL;
    Q1SAPV :=P1XVX;
    Q1IAPX :=P1XVXX;
    END_IF;
IF FP THEN
    Q1COMM:=FALSE;
    P1COMM:=TRUE;
    END_IF;




IF FQP THEN
    Q1DPX :=Q1DAPX;
    Q1SWX :=Q1SSPH;
    Q1SLX :=Q1SSPL;
    Q1SAPV :=Q1XVX;
    Q1IAPX :=Q1XVXX;
    P1DPX :=P1DAPX;
    P1SWX :=P1SSPH;
    P1SLX :=P1SSPL;
    P1SAPV :=P1XVX;
    P1IAPX :=P1XVXX;
    Q1COMM :=FALSE;
    P1COMM := FALSE;
    END_IF;
    
(*-========================-*)



(*СКВАЖИНА 2*)
(*-========================-*)




(*ВЫВОД СКВАЖИНЫ ИЗ АЛГОРИТМА ПЕРЕВОД В РУЧНОЙ РЕЖИМ*)
IF ILCX22 THEN ILCX2:=TRUE; END_IF;
IF P2DAPX OR Q2DAPX OR (P2SHWX<P2XVXX) OR (P2SHLX>P2XVXX) OR (Q2SHWX<Q2XVXX) OR (Q2SHLX>Q2XVXX) OR ILCX2 OR IFXX2 THEN
    ILCX2 := TRUE;
    Q2COMM:=TRUE;
    P2COMM:=TRUE;
    END_IF;

IF COMM THEN
    Q2COMM :=TRUE;
    P2COMM :=TRUE;
END_IF;
IF NOT P2DAPX AND NOT Q2DAPX AND NOT IFXX2 THEN
    Q2XV:=Q2XVXX;
    END_IF;

(*ПРОВЕРКА МАКСИМАЛЬНЫХ ПОЛОЖЕНИЙ КЛАПАНА РЕГУЛЯТОРА*)

IF  XCCP2>=SAPH2 THEN
    KLR2MS :=TRUE;
    ELSE
    KLR2MS :=FALSE;
    END_IF;
    
IF XCCP2<=SAPL2 THEN
    KLR2M :=TRUE;
    ELSE
    KLR2M :=FALSE;
    END_IF;

(*ЗАДАЧА ПАРАМЕТРОВ, ЗАПРЕТ ЗАДАЧИ НЕВЫПОЛНИМЫХ УСЛОВИЙ*)
(*ДАВЛЕНИЕ СКВАЖИНЫ ТРЕБУЕМОЕ*)
IF P2SSPL > PXVX THEN
    P2XVX :=P2SSPL;
    END_IF;
IF P2SSPH < PXVX THEN
    P2XVX :=P2SSPH;
    END_IF;
    
IF P2SSPL < PXVX AND P2SSPH > PXVX THEN
    P2XVX :=PXVX;
    END_IF; 


(*РАСХОД *)

IF QR1 THEN
    Q2XVX :=Q2SAPV1;
    END_IF;
IF QR2 THEN
    Q2XVX:=Q2SAPV2*0.01*Q2SHWX;
    END_IF;
IF QR3 THEN 
    Q2XVX :=((Q2SHWX-Q2SHLX)/100)*Q2SAPV3+Q2SHLX;
    END_IF;                            

IF QR4 THEN
    Q2XVX :=Q42;
    END_IF;
    
(*ЗАПРЕТ НЕ ВЫПОЛНИМЫХ УСЛОВИЙ*)   

IF Q2SSPL > Q2XVX THEN
    Q2XVX1 :=Q2SSPL;
    END_IF;
    
IF Q2SSPH < Q2XVX THEN
    Q2XVX1 :=Q2SSPH;
    END_IF;
    
IF Q2SSPL < Q2XVX AND Q2SSPH > Q2XVX THEN
    Q2XVX1 :=Q2XVX;
    END_IF;
    
    
(*СЕЛЕКТОР ОСНОВНОГО И КОРРЕКТИРУЮЩЕГО ПАРАМЕТРОВ*)

IF COMM OR FP THEN
    Q2DPX:=P2DAPX;
    Q2SWX :=P2SSPH;
    Q2SLX :=P2SSPL;
    Q2SAPV :=P2XVX;
    Q2IAPX :=P2XVXX;
    END_IF;
IF FP THEN
    Q2COMM:=FALSE;
    P2COMM:=TRUE;
    END_IF;




IF FQP THEN
    Q2DPX :=Q2DAPX;
    Q2SWX :=Q2SSPH;
    Q2SLX :=Q2SSPL;
    Q2SAPV :=Q2XVX;
    Q2IAPX :=Q2XVXX;
    P2DPX :=P2DAPX;
    P2SWX :=P2SSPH;
    P2SLX :=P2SSPL;
    P2SAPV :=P2XVX;
    P2IAPX :=P2XVXX;
    Q2COMM :=FALSE;
    P2COMM := FALSE;
    END_IF;

(*-========================-*)



(*СКВАЖИНА 3*)
(*-========================-*)




(*ВЫВОД СКВАЖИНЫ ИЗ АЛГОРИТМА ПЕРЕВОД В РУЧНОЙ РЕЖИМ*)
IF ILCX33 THEN ILCX3:=TRUE; END_IF;
IF P3DAPX OR Q3DAPX OR (P3SHWX<P3XVXX) OR (P3SHLX>P3XVXX) OR (Q3SHWX<Q3XVXX) OR (Q3SHLX>Q3XVXX) OR ILCX3 OR IFXX3 AND X3=1 THEN
    ILCX3 := TRUE;
    Q3COMM:=TRUE;
    P3COMM:=TRUE;
    END_IF;
IF COMM THEN
    Q3COMM:=TRUE;
    P3COMM:=TRUE;
    END_IF;
    
    IF NOT P3DAPX AND NOT Q3DAPX AND NOT IFXX3 THEN
    Q3XV:=Q3XVXX;
    END_IF;
    

(*ПРОВЕРКА МАКСИМАЛЬНЫХ ПОЛОЖЕНИЙ КЛАПАНА РЕГУЛЯТОРА*)

IF  XCCP3>=SAPH3 THEN
    KLR3MS :=TRUE;
    ELSE
    KLR3MS :=FALSE;
    END_IF;
    
IF XCCP3<=SAPL3 THEN
    KLR3M :=TRUE;
    ELSE
    KLR3M :=FALSE;
    END_IF;

(*ЗАДАЧА ПАРАМЕТРОВ, ЗАПРЕТ ЗАДАЧИ НЕВЫПОЛНИМЫХ УСЛОВИЙ*)
(*ДАВЛЕНИЕ СКВАЖИНЫ ТРЕБУЕМОЕ*)
IF P3SSPL > PXVX THEN
    P3XVX :=P3SSPL;
    END_IF;
IF P3SSPH < PXVX THEN
    P3XVX :=P3SSPH;
    END_IF;
    
IF P3SSPL < PXVX AND P3SSPH > PXVX THEN
    P3XVX :=PXVX;
    END_IF; 


(*РАСХОД *)

IF QR1 THEN
    Q3XVX :=Q3SAPV1;
    END_IF;
IF QR2 THEN
    Q3XVX:=Q3SAPV2*0.01*Q2SHWX;
    END_IF;
IF QR3 THEN 
    Q3XVX :=((Q3SHWX-Q3SHLX)/100)*Q3SAPV3+Q3SHLX;
    END_IF;                            

IF QR4 THEN
    Q3XVX :=Q43;
    END_IF;
    
(*ЗАПРЕТ НЕ ВЫПОЛНИМЫХ УСЛОВИЙ*)   

IF Q3SSPL > Q3XVX THEN
    Q3XVX1 :=Q3SSPL;
    END_IF;
    
IF Q3SSPH < Q3XVX THEN
    Q3XVX1 :=Q3SSPH;
    END_IF;
    
IF Q3SSPL < Q3XVX AND Q3SSPH > Q3XVX THEN
    Q3XVX1 :=Q3XVX;
    END_IF;
    
    
(*СЕЛЕКТОР ОСНОВНОГО И КОРРЕКТИРУЮЩЕГО ПАРАМЕТРОВ*)

IF COMM OR FP THEN
    Q3DPX:=P3DAPX;
    Q3SWX :=P3SSPH;
    Q3SLX :=P3SSPL;
    Q3SAPV :=P3XVX;
    Q3IAPX :=P3XVXX;
    END_IF;
IF FP THEN
    Q3COMM:=FALSE;
    P3COMM:=TRUE;
    END_IF;




IF FQP THEN
    Q3DPX :=Q3DAPX;
    Q3SWX :=Q3SSPH;
    Q3SLX :=Q3SSPL;
    Q3SAPV :=Q3XVX;
    Q3IAPX :=Q3XVXX;
    P3DPX :=P3DAPX;
    P3SWX :=P3SSPH;
    P3SLX :=P3SSPL;
    P3SAPV :=P3XVX;
    P3IAPX :=P3XVXX;
    Q3COMM :=FALSE;
    P3COMM := FALSE;
    END_IF;
    (*-========================-*)


(*СКВАЖИНА 4*)



(*-========================-*)
(*ВЫВОД СКВАЖИНЫ ИЗ АЛГОРИТМА ПЕРЕВОД В РУЧНОЙ РЕЖИМ*)
IF ILCX44 THEN ILCX4:=TRUE; END_IF;
IF P4DAPX OR Q4DAPX OR (P4SHWX<P4XVXX) OR (P4SHLX>P4XVXX) OR (Q4SHWX<Q4XVXX) OR (Q4SHLX>Q4XVXX) OR ILCX4 OR IFXX4 AND X4=1 THEN
    ILCX4 := TRUE;
    Q4COMM:=TRUE;
    P4COMM:=TRUE;
    END_IF;
IF COMM THEN
    Q4COMM :=TRUE;
    P4COMM :=TRUE;
    END_IF;
    
IF NOT P4DAPX AND NOT Q4DAPX AND NOT IFXX4 THEN
    Q4XV:=Q4XVXX;
    END_IF;

(*ПРОВЕРКА МАКСИМАЛЬНЫХ ПОЛОЖЕНИЙ КЛАПАНА РЕГУЛЯТОРА*)

IF  XCCP4>=SAPH4 THEN
    KLR4MS :=TRUE;
    ELSE
    KLR4MS :=FALSE;
    END_IF;
    
IF XCCP4<=SAPL4 THEN
    KLR4M :=TRUE;
    ELSE
    KLR4M :=FALSE;
    END_IF;

(*ЗАДАЧА ПАРАМЕТРОВ, ЗАПРЕТ ЗАДАЧИ НЕВЫПОЛНИМЫХ УСЛОВИЙ*)
(*ДАВЛЕНИЕ СКВАЖИНЫ ТРЕБУЕМОЕ*)
IF P4SSPL > PXVX THEN
    P4XVX :=P4SSPL;
    END_IF;
IF P4SSPH < PXVX THEN
    P4XVX :=P4SSPH;
    END_IF;
    
IF P4SSPL < PXVX AND P4SSPH > PXVX THEN
    P4XVX :=PXVX;
    END_IF; 


(*РАСХОД *)

IF QR1 THEN
    Q4XVX :=Q4SAPV1;
    END_IF;
IF QR2 THEN
    Q4XVX:=Q4SAPV2*0.01*Q4SHWX;
    END_IF;
IF QR3 THEN 
    Q4XVX :=((Q4SHWX-Q4SHLX)/100)*Q4SAPV3+Q4SHLX;
    END_IF;                            

IF QR4 THEN
    Q4XVX :=Q44;
    END_IF;
    
(*ЗАПРЕТ НЕ ВЫПОЛНИМЫХ УСЛОВИЙ*)   

IF Q4SSPL > Q4XVX THEN
    Q4XVX1 :=Q4SSPL;
    END_IF;
    
IF Q4SSPH < Q4XVX THEN
    Q4XVX1 :=Q4SSPH;
    END_IF;
    
IF Q4SSPL < Q4XVX AND Q4SSPH > Q4XVX THEN
    Q4XVX1 :=Q4XVX;
    END_IF;
    
    
(*СЕЛЕКТОР ОСНОВНОГО И КОРРЕКТИРУЮЩЕГО ПАРАМЕТРОВ*)

IF COMM OR FP THEN
    Q4DPX:=P4DAPX;
    Q4SWX :=P4SSPH;
    Q4SLX :=P4SSPL;
    Q4SAPV :=P4XVX;
    Q4IAPX :=P4XVXX;
    END_IF;
IF FP THEN
    Q4COMM:=FALSE;
    P4COMM:=TRUE;
    END_IF;




IF FQP THEN
    Q4DPX :=Q4DAPX;
    Q4SWX :=Q4SSPH;
    Q4SLX :=Q4SSPL;
    Q4SAPV :=Q4XVX;
    Q4IAPX :=Q4XVXX;
    P4DPX :=P4DAPX;
    P4SWX :=P4SSPH;
    P4SLX :=P4SSPL;
    P4SAPV :=P4XVX;
    P4IAPX :=P4XVXX;
    Q4COMM :=FALSE;
    P4COMM := FALSE;
    END_IF;
    
    (*-========================-*)



(*СКВАЖИНА 5*)



(*-========================-*)
(*ВЫВОД СКВАЖИНЫ ИЗ АЛГОРИТМА ПЕРЕВОД В РУЧНОЙ РЕЖИМ*)
IF ILCX55 THEN ILCX5:=TRUE; END_IF;
IF P5DAPX OR Q5DAPX OR (P5SHWX<P5XVXX) OR (P5SHLX>P5XVXX) OR (Q5SHWX<Q5XVXX) OR (Q5SHLX>Q5XVXX) OR ILCX5 OR IFXX5 AND X5=1 THEN
    ILCX5 := TRUE;
    Q5COMM:=TRUE;
    P5COMM:=TRUE;
    END_IF;
IF COMM THEN
    Q5COMM :=TRUE;
    P5COMM :=TRUE;
    END_IF;

IF NOT P5DAPX AND NOT Q5DAPX AND NOT IFXX5 THEN
    Q5XV:=Q5XVXX;
    END_IF;
(*ПРОВЕРКА МАКСИМАЛЬНЫХ ПОЛОЖЕНИЙ КЛАПАНА РЕГУЛЯТОРА*)

IF  XCCP5>=SAPH5 THEN
    KLR5MS :=TRUE;
    ELSE
    KLR5MS :=FALSE;
    END_IF;
    
IF XCCP5<=SAPL5 THEN
    KLR5M :=TRUE;
    ELSE
    KLR5M :=FALSE;
    END_IF;

(*ЗАДАЧА ПАРАМЕТРОВ, ЗАПРЕТ ЗАДАЧИ НЕВЫПОЛНИМЫХ УСЛОВИЙ*)
(*ДАВЛЕНИЕ СКВАЖИНЫ ТРЕБУЕМОЕ*)
IF P5SSPL > PXVX THEN
    P5XVX :=P5SSPL;
    END_IF;
IF P5SSPH < PXVX THEN
    P5XVX :=P5SSPH;
    END_IF;
    
IF P5SSPL < PXVX AND P2SSPH > PXVX THEN
    P5XVX :=PXVX;
    END_IF; 


(*РАСХОД *)

IF QR1 THEN
    Q5XVX :=Q5SAPV1;
    END_IF;
IF QR2 THEN
    Q5XVX:=Q5SAPV2*0.01*Q5SHWX;
    END_IF;
IF QR3 THEN 
    Q5XVX :=((Q5SHWX-Q5SHLX)/100)*Q5SAPV3+Q5SHLX;
    END_IF;                            

IF QR4 THEN
    Q5XVX :=Q45;
    END_IF;
    
(*ЗАПРЕТ НЕ ВЫПОЛНИМЫХ УСЛОВИЙ*)   

IF Q5SSPL > Q5XVX THEN
    Q5XVX1 :=Q5SSPL;
    END_IF;
    
IF Q5SSPH < Q5XVX THEN
    Q5XVX1 :=Q5SSPH;
    END_IF;
    
IF Q5SSPL < Q5XVX AND Q5SSPH > Q5XVX THEN
    Q5XVX1 :=Q5XVX;
    END_IF;
    
    
(*СЕЛЕКТОР ОСНОВНОГО И КОРРЕКТИРУЮЩЕГО ПАРАМЕТРОВ*)

IF COMM OR FP THEN
    Q5DPX:=P5DAPX;
    Q5SWX :=P5SSPH;
    Q5SLX :=P5SSPL;
    Q5SAPV :=P5XVX;
    Q5IAPX :=P5XVXX;
    END_IF;
IF FP THEN
    Q5COMM:=FALSE;
    P5COMM:=TRUE;
    END_IF;




IF FQP THEN
    Q5DPX :=Q5DAPX;
    Q5SWX :=Q5SSPH;
    Q5SLX :=Q5SSPL;
    Q5SAPV :=Q5XVX;
    Q5IAPX :=Q5XVXX;
    P5DPX :=P5DAPX;
    P5SWX :=P5SSPH;
    P5SLX :=P5SSPL;
    P5SAPV :=P5XVX;
    P5IAPX :=P5XVXX;
    Q5COMM :=FALSE;
    P5COMM := FALSE;
    END_IF;



    (*-========================-*)
(*СКВАЖИНА 6*)
(*-========================-*)



(*ВЫВОД СКВАЖИНЫ ИЗ АЛГОРИТМА ПЕРЕВОД В РУЧНОЙ РЕЖИМ*)
IF ILCX66 THEN ILCX6:=TRUE; END_IF;
IF P6DAPX OR Q6DAPX OR (P6SHWX<P6XVXX) OR (P6SHLX>P6XVXX) OR (Q6SHWX<Q6XVXX) OR (Q6SHLX>Q6XVXX) OR ILCX6 OR IFXX6 AND X6=1 THEN
    ILCX6 := TRUE;
    Q6COMM:=TRUE;
    P6COMM:=TRUE;
    END_IF;
IF COMM THEN
    Q6COMM:=TRUE;
    P6COMM:=TRUE;
    END_IF;
    
IF NOT P6DAPX AND NOT Q6DAPX AND NOT IFXX6 THEN
    Q6XV:=Q6XVXX;
    END_IF;    

(*ПРОВЕРКА МАКСИМАЛЬНЫХ ПОЛОЖЕНИЙ КЛАПАНА РЕГУЛЯТОРА*)

IF  XCCP6>=SAPH6 THEN
    KLR6MS :=TRUE;
    ELSE
    KLR6MS :=FALSE;
    END_IF;
    
IF XCCP6<=SAPL6 THEN
    KLR6M :=TRUE;
    ELSE
    KLR6M :=FALSE;
    END_IF;

(*ЗАДАЧА ПАРАМЕТРОВ, ЗАПРЕТ ЗАДАЧИ НЕВЫПОЛНИМЫХ УСЛОВИЙ*)
(*ДАВЛЕНИЕ СКВАЖИНЫ ТРЕБУЕМОЕ*)
IF P6SSPL > PXVX THEN
    P6XVX :=P6SSPL;
    END_IF;
IF P6SSPH < PXVX THEN
    P6XVX :=P6SSPH;
    END_IF;
    
IF P6SSPL < PXVX AND P6SSPH > PXVX THEN
    P6XVX :=PXVX;
    END_IF; 


(*РАСХОД *)

IF QR1 THEN
    Q6XVX :=Q6SAPV1;
    END_IF;
IF QR2 THEN
    Q6XVX:=Q6SAPV2*0.01*Q6SHWX;
    END_IF;
IF QR3 THEN 
    Q6XVX :=((Q6SHWX-Q6SHLX)/100)*Q6SAPV3+Q6SHLX;
    END_IF;                            

IF QR4 THEN
    Q6XVX :=Q46;
    END_IF;
    
(*ЗАПРЕТ НЕ ВЫПОЛНИМЫХ УСЛОВИЙ*)   

IF Q6SSPL > Q6XVX THEN
    Q6XVX1 :=Q6SSPL;
    END_IF;
    
IF Q6SSPH < Q6XVX THEN
    Q6XVX1 :=Q6SSPH;
    END_IF;
    
IF Q6SSPL < Q6XVX AND Q6SSPH > Q6XVX THEN
    Q6XVX1 :=Q6XVX;
    END_IF;
    
    
(*СЕЛЕКТОР ОСНОВНОГО И КОРРЕКТИРУЮЩЕГО ПАРАМЕТРОВ*)

IF COMM OR FP THEN
    Q6DPX:=P6DAPX;
    Q6SWX :=P6SSPH;
    Q6SLX :=P6SSPL;
    Q6SAPV :=P6XVX;
    Q6IAPX :=P6XVXX;
    END_IF;
IF FP THEN
    Q6COMM:=FALSE;
    P6COMM:=TRUE;
    END_IF;


IF FQP THEN
    Q6DPX :=Q6DAPX;
    Q6SWX :=Q6SSPH;
    Q6SLX :=Q6SSPL;
    Q6SAPV :=Q6XVX;
    Q6IAPX :=Q6XVXX;
    P6DPX :=P6DAPX;
    P6SWX :=P6SSPH;
    P6SLX :=P6SSPL;
    P6SAPV :=P6XVX;
    P6IAPX :=P6XVXX;
    Q6COMM :=FALSE;
    P6COMM := FALSE;
    END_IF;
    
    
    
    
    (*-========================-*)
(*СКВАЖИНА 7*)




(*-========================-*)
(*ВЫВОД СКВАЖИНЫ ИЗ АЛГОРИТМА ПЕРЕВОД В РУЧНОЙ РЕЖИМ*)
IF ILCX77 THEN ILCX7:=TRUE; END_IF;
IF P7DAPX OR Q7DAPX OR (P7SHWX<P7XVXX) OR (P7SHLX>P7XVXX) OR (Q7SHWX<Q7XVXX) OR (Q7SHLX>Q7XVXX) OR ILCX7 OR IFXX7 AND X7=1 THEN
    ILCX7 := TRUE;
    Q7COMM:=TRUE;
    P7COMM:=TRUE;
    END_IF;
IF COMM THEN
    Q7COMM:=TRUE;
    P7COMM:=TRUE;
    END_IF;

IF NOT P7DAPX AND NOT Q7DAPX AND NOT IFXX7 THEN
    Q7XV:=Q7XVXX;
    END_IF;
(*ПРОВЕРКА МАКСИМАЛЬНЫХ ПОЛОЖЕНИЙ КЛАПАНА РЕГУЛЯТОРА*)

IF  XCCP7>=SAPH7 THEN
    KLR7MS :=TRUE;
    ELSE
    KLR7MS :=FALSE;
    END_IF;
    
IF XCCP7<=SAPL7 THEN
    KLR7M :=TRUE;
    ELSE
    KLR7M :=FALSE;
    END_IF;

(*ЗАДАЧА ПАРАМЕТРОВ, ЗАПРЕТ ЗАДАЧИ НЕВЫПОЛНИМЫХ УСЛОВИЙ*)
(*ДАВЛЕНИЕ СКВАЖИНЫ ТРЕБУЕМОЕ*)
IF P7SSPL > PXVX THEN
    P7XVX :=P7SSPL;
    END_IF;
IF P7SSPH < PXVX THEN
    P7XVX :=P7SSPH;
    END_IF;
    
IF P7SSPL < PXVX AND P7SSPH > PXVX THEN
    P7XVX :=PXVX;
    END_IF; 


(*РАСХОД *)

IF QR1 THEN
    Q7XVX :=Q7SAPV1;
    END_IF;
IF QR2 THEN
    Q7XVX:=Q7SAPV2*0.01*Q7SHWX;
    END_IF;
IF QR3 THEN 
    Q7XVX :=((Q7SHWX-Q7SHLX)/100)*Q7SAPV3+Q7SHLX;
    END_IF;                            

IF QR4 THEN
    Q7XVX :=Q47;
    END_IF;
    
(*ЗАПРЕТ НЕ ВЫПОЛНИМЫХ УСЛОВИЙ*)   

IF Q7SSPL > Q7XVX THEN
    Q7XVX1 :=Q7SSPL;
    END_IF;
    
IF Q7SSPH < Q7XVX THEN
    Q7XVX1 :=Q7SSPH;
    END_IF;
    
IF Q7SSPL < Q7XVX AND Q7SSPH > Q7XVX THEN
    Q7XVX1 :=Q7XVX;
    END_IF;
    
    
(*СЕЛЕКТОР ОСНОВНОГО И КОРРЕКТИРУЮЩЕГО ПАРАМЕТРОВ*)

IF COMM OR FP THEN
    Q7DPX:=P7DAPX;
    Q7SWX :=P7SSPH;
    Q7SLX :=P7SSPL;
    Q7SAPV :=P7XVX;
    Q7IAPX :=P7XVXX;
    END_IF;
IF FP THEN
    Q7COMM:=FALSE;
    P7COMM:=TRUE;
    END_IF;




IF FQP THEN
    Q7DPX :=Q7DAPX;
    Q7SWX :=Q7SSPH;
    Q7SLX :=Q7SSPL;
    Q7SAPV :=Q7XVX;
    Q7IAPX :=Q7XVXX;
    P7DPX :=P7DAPX;
    P7SWX :=P7SSPH;
    P7SLX :=P7SSPL;
    P7SAPV :=P7XVX;
    P7IAPX :=P7XVXX;
    Q7COMM :=FALSE;
    P7COMM := FALSE;
    END_IF;
    
END_FUNCTION_BLOCK