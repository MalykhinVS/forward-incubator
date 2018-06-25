CREATE OR REPLACE procedure saveSigners(pv_fio      scd_signers.v_fio%TYPE,
                                        pID_MANAGER scd_signers.ID_MANAGER%TYPE,
                                        pACTION     in number) is
  p_manag scd_signers.ID_manager%TYPE;
begin
  select ss.id_manager into p_manag from scd_signers ss;
  case
    when pAction = 1 then
      case
        when PID_MANAGER = p_manag then
          raise_application_error(-1,
                                  'такая запись уже существует');
        else
          insert into scd_signers
            (v_fio, ID_manager)
          VALUES
            (pv_fio, PID_MANAGER);
      end case;
    when pAction = 2 then
      update scd_signers ss
         set ss.ID_MANAGER = pID_MANAGER
       where ss.V_FIO = pv_fio;
    when pACTION = 3 then
      delete from scd_signers ss where ID_MANAGER = pID_MANAGER;
  end case;
END;
