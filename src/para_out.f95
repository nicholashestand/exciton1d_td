!*********************************************************************!
!        Write the simulation parameters to a file so that the        !
!   simulation can be reproduced at a later time.                     !
!*********************************************************************!
subroutine para_out()
    use commonvar
    implicit none

    integer f_no
    character*100 f_name

    f_no = 26
    f_name =trim(task_title)//'_para.csv'
    open( unit=f_no, file = f_name )
    
    write( f_no, * ) 'parameter, values, all energies in cm-1'
    write( f_no, * ) 'task title, ', trim(task_title)
    write( f_no, * ) 'nmol, ', nmol
    write( f_no, * ) '@@@@@@,@@@@@@'
    write( f_no, * ) 'basis state, on'
    write( f_no, * ) 'fe, ', fe_state
    write( f_no, * ) 'ct, ', ct_state
    write( f_no, * ) 'total,',kount
    write( f_no, * ) '@@@@@@,@@@@@@'
    write( f_no, * ) 'JCoul,',JCoul
    write( f_no, * ) 'ES1,',ES1
    write( f_no, * ) 'te,',te
    write( f_no, * ) 'th,',th
    write( f_no, * ) 'ECT,',ECT    
    write( f_no, * ) '@@@@@@,@@@@@@'
    write( f_no, * ) 'tmax,',tmax
    write( f_no, * ) 't0_state,', t0_state
    write( f_no, * ) 'tstep,',tstep
    close( f_no )

end subroutine
