!*********************************************************************!
!   subroutine reads parameters from user input file 
!   most variables reside in the commonvar module and are used
!   throughout the program in various subroutines
!*********************************************************************!
subroutine read_in_para()
    use commonvar
    implicit none

    logical         exists
    character*100   buff, label, fname
    integer         fno, ios, line, pos, errstat
    parameter       (fno = 201)
    
    !get the input file name as the first argument from
    !command line, if given otherwise use default parameters
    call get_command_argument( 1, fname, status = errstat )
    if ( errstat .ne. 0 ) then
        print*, 'No control file given. Using default parameters'
        goto 1010
    end if
    !check that the given input file exists, abort if not
    inquire( file = trim( fname ), exist = exists )
    if ( .not. exists ) then
        print*, 'Input file not found...aborting'
        stop
    end if
    
    !open the user input file and read in the parameters
    open( unit = fno, file = fname, status = 'old', action = 'read' )
    ios = 0  !the in/out status
    line = 0 !the current line number
    print*, 'Reading the input file...'
    print*, '**********************************'//&
            '**********************************'
    do while ( ios == 0 ) !continue the loop until end of file
        read( fno, '(a)', iostat = ios ) buff !read a line
        if ( ios == 0 ) then
            line = line + 1
            !parse the line into a label and parameter
            pos   = scan( buff, ' ' )
            label = buff( 1:pos )
            buff  = buff( pos + 1: )
            if ( label(1:1) == '#' ) cycle !treat as a comment
            !find the label and assign the appropriate value to 
            !the variable
            select case ( label )
            case('task_title')
                read( buff, *, iostat=ios ) task_title
                print*, '   Setting task_title to: '//trim(task_title)
            case('nmol')
                read( buff, *, iostat=ios ) nmol
                print'(a,i4)', '    Setting nmol to: ', nmol
            case('JCoul')
                read( buff, *, iostat=ios) JCoul
                print'(a,f8.2)', '    Setting JCoul to (cm-1): ', JCoul   
            case('ES1')
                read( buff, *, iostat=ios) ES1
                print'(a,f8.2)', '    Setting ES1 to ', ES1
            case('te')
                read( buff, *, iostat=ios) te
                print'(a,f8.2)', '    Setting te to (cm-1): ', te   
            case('th')
                read( buff, *, iostat=ios) th
                print'(a,f8.2)', '    Setting th to (cm-1): ', th   
            case('ECT')
                read( buff, *, iostat=ios) ECT
                print'(a,f8.2)', '    Setting ECT to (cm-1): ', ECT
            case('fe_state')
                read( buff, *, iostat=ios) fe_state
                if ( fe_state ) &
                    print*, '   Frenkel states are turned on.'
                if ( .not.fe_state ) &
                    print*, '   Frenkel states are turned off.'
            case('ct_state')
                read( buff, *, iostat=ios) ct_state
                if ( ct_state ) &
                    print*, '   CT states are turned on.'
                if ( .not.ct_state ) &
                    print*, '   CT states are turned off.'
            case('t0_state')
                read( buff, *, iostat=ios) t0_state
                print'(a,i4)', '    The initial state of the system has'//&
                               ' the exciton on molecule ', t0_state
            case('tmax')
                read( buff, *, iostat=ios) tmax
                print'(a,i6)', '    Setting tmax to ', tmax
            case('tstep')
                read( buff, *, iostat=ios) tstep
                print'(a,f8.2)', '    Setting the step size to ', tstep
            case default
                print*, '    invalid label at line, ', line
                print*, '    press enter to continue or ctrl+c to abort'
                read*
            end select
        end if
    end do
    close( fno )     !close the file
    print*, '**********************************'//&
            '**********************************'
    print*, 'Done reading the input file...'
    
1010 continue

end subroutine
