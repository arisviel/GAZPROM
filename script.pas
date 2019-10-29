var
    PrvMenu : int;
    AckVAR : TOneScriptExVAR;

    ArrBoolVal:array of boolean;  
    ArrFloatVal:array of real;

    ArrMenu: array [0..8] of TGrDisc;
    ArrPanel: array [0..8] of TGrPanel;
    ArrControlBtn: array [0..3] of TGrButton;
    ActiveControl : boolean;
    BtnNum : INT;  
    AckColor : TColor;
    

//*********************************************************
//срабатывает после загрузки кадра  (в RUN режиме)
procedure sys_OnPageOpen;
begin
    ArrMenu := [MENU_0_ON,MENU_1_ON,MENU_2_ON,MENU_3_ON,MENU_4_ON];
    ArrPanel := [PANEL_0,PANEL_1,PANEL_2,PANEL_3,PANEL_TRENDS];
    ArrControlBtn := [BTN_REPAIR,BTN_MANUAL,BTN_INVERT,BTN_EMYL];
    WinHeightAct();
    
    AckColor := PANEL_ACK.BRUSHCOLOR;
end;

//****_*****************************************************
//срабатывает периодически по таймеру (задается в общих настройках)
procedure sys_OnPageTimer;
begin        
end;

//*********************************************************
//срабатывает перед закрытием кадра (в RUN режиме)
procedure sys_OnPageClose;
begin
end;
//*********************************************************
// срабатывает при скрытии кадра (если включен редим кэширования)
procedure sys_OnPageHide;
begin
end;
//*********************************************************
// срабатывает при отображении кадра (после sys_OnPageHide)
procedure sys_OnPageVisible;
begin
end;

//*********************************************************
// Переключение между вкладками меню
procedure MenuClick(NewMenu: INT);
begin
    if (PrvMenu <> NewMenu) then
    begin
        if ActiveControl then    
            HideAck();    
        ArrMenu[PrvMenu].beginupdate;
        ArrMenu[PrvMenu].Visible := FALSE;
        ArrMenu[PrvMenu].endupdate;
    
        ArrMenu[NewMenu].beginupdate;
        ArrMenu[NewMenu].Visible := TRUE;
        ArrMenu[NewMenu].endupdate;
        
        ArrPanel[PrvMenu].beginupdate;
        ArrPanel[PrvMenu].Visible := FALSE;
        ArrPanel[PrvMenu].endupdate; 
               
        ArrPanel[NewMenu].beginupdate;
        ArrPanel[NewMenu].Visible := TRUE;
        ArrPanel[NewMenu].endupdate;    

        PrvMenu := NewMenu;
        WinHeightAct();
    end;
end;
//*********************************************************
// Процедура отображения окна подтверждения
procedure HideAck();
begin
    ArrControlBtn[BtnNum].beginUpdate;
    ArrControlBtn[BtnNum].BrushBlink(bfSTOP, clBtnFace);
    ArrControlBtn[BtnNum].DOWN:=FALSE;
    if ArrControlBtn[BtnNum].endupdate then
        ArrControlBtn[BtnNum].Draw;
    ActiveControl := FALSE;
    PANEL_ACK.beginupdate;
    PANEL_ACK.Visible := FALSE; 
    if PANEL_ACK.endupdate then
        PANEL_ACK.draw;
end;

//*********************************************************
// Воздействие на элементы управления (Кнопки)
procedure ControlClickBtn(NumSender: INT; Str: string; Tag: string; Val:boolean);
var TmpActiveControl: boolean;
begin                                                                   
    TmpActiveControl := ActiveControl; 
    if TmpActiveControl then
        HideAck();
    if (NOT (TmpActiveControl) OR (NumSender<>BtnNum)) then
        DisplayAck(NumSender,Str,Tag,Val);
    WinHeightAct();
end;

//*********************************************************
// Процедура отображения окна подтверждения
procedure DisplayAck(NumSender: INT; Str: string; Tag: string; Val:boolean);
begin
    ActiveControl := TRUE;
    BtnNum := NumSender;   
    ArrControlBtn[BtnNum].beginUpdate;
    ArrControlBtn[BtnNum].DOWN:=TRUE;
    ArrControlBtn[BtnNum].BrushBlink(bfSLOW, AckColor);
    if ArrControlBtn[BtnNum].endupdate then
        ArrControlBtn[BtnNum].Draw;  
    PANEL_ACK.beginupdate;
    PANEL_ACK.Visible := TRUE;
    ACK_STR.Text := Str;
    ACK_VAL.Enabled := Val; 
    if PANEL_ACK.endupdate then
        PANEL_ACK.draw;
    AckVAR := INITVARBYPARAMNAME(Tag,pmActive)    
end;

//*********************************************************
// Подтверждение действия
procedure OkAck();
begin
    AckVAR.SETVALUE(ACK_VAL.Enabled,TRUE);
    HideAck();
    WinHeightAct();
end;

// Отмена действия
procedure CancelAck();
begin
    HideAck();
    WinHeightAct();
end;

procedure WinHeightAct();
begin
    //Борьба с появляющимся слайдером
    ADD_PANEL.beginupdate;
    ADD_PANEL.Visible := TRUE;
    ADD_PANEL.endupdate;
    TEKPAGE.Height := Panel.Height + 40 + 29; 

    ADD_PANEL.beginupdate;
    
    CPU_BAD.beginupdate;
    CPU_BAD.Height := Panel.Height;
    
    ADD_PANEL.Visible := FALSE;
    ADD_PANEL.endupdate;    
    //Борьба окончена
    
    CPU_BAD.Height := Panel.Height;
    CPU_BAD.Draw;
        
    TEKPAGE.Height := Panel.Height + 40 + 29;
    TEKPAGE.Draw;
end;

procedure BTN_REPAIR_OFF_ONCLICK;
begin
ControlClickBtn(0,'Подать команду "Деактивировать режим ремонт"?','._ST_REG_CRPX',FALSE);
end;
procedure BTN_REPAIR_ON_ONCLICK;
begin
ControlClickBtn(0,'Подать команду "Активировать режим ремонт"?','._ST_REG_CRPX',TRUE);
end;
procedure BTN_MANUAL_OFF_ONCLICK;
begin
ControlClickBtn(1,'Подать команду "Активировать режим ручной"?','._ST_REG_COMM',FALSE);
end;
procedure BTN_MANUAL_ON_ONCLICK;
begin
ControlClickBtn(1,'Подать команду "Активировать режим автоматический"?','._ST_REG_COMM',TRUE);
end;
procedure BTN_INVERT_OFF_ONCLICK;
begin
ControlClickBtn(2,'Подать команду "Активировать режим прямого управления"?','._ST_REG_CCRM',FALSE);
end;
procedure BTN_INVERT_ON_ONCLICK;
begin
ControlClickBtn(2,'Подать команду "Активировать режим обратного управления"?','._ST_REG_CCRM',TRUE);
end;
procedure BTN_EMYL_OFF_ONCLICK;
begin
ControlClickBtn(3,'Подать команду "Сброс режим эмуляции"?','._ST_REG_CIMX',FALSE);
end;
procedure BTN_EMYL_ON_ONCLICK;
begin
ControlClickBtn(3,'Подать команду "Активировать режим эмуляции"?','._ST_REG_CIMX',TRUE);
end;












