program VoidDistances2020
    use VoidDistances
    type(FakeCMBParams) CMB
    integer :: i
    character :: action
    logical :: do_metric, do_geodesics

    write(*,*) "Hello void world!"

    write(*,*) "Usage:"
    write(*,*) trim(adjustl(GetCommandName())), " action H0 Omega_k Omega_DE w_DE delta0 z_Boundary"
    write(*,*) ""
    write(*,*) "where action is either:"
    write(*,*) "  g  (geodesic integration)"
    write(*,*) "  m  (metric functions)"
    write(*,*) "  b  (both metric and geodesics)"
    write(*,*) ""
    write(*,*) "and all other parameters are real values."
    write(*,*)

    write(*,*) "Will crash if you do not supply these."


    CMB%VCP%profile = 19
    CMB%VCP%alpha = 1.0
    CMB%VCP%beta = 1.0

    i = 0

    i = i + 1
    call get_command_argument(i, action)

    i = i + 1
    CMB%H0 = GetArgFloat(i)
    i = i + 1
    CMB%omk = GetArgFloat(i)
    i = i + 1
    CMB%omv = GetArgFloat(i)
    i = i + 1
    CMB%w = GetArgFloat(i)
    i = i + 1
    CMB%VCP%delta0 = GetArgFloat(i)
    i = i + 1
    CMB%VCP%zB = GetArgFloat(i)

    CMB%omdmh2 = -10000 ! unused.

    call ResetVoid()

    VoidTesting = .true.
    VoidTestingIntegrationOutput = .false.

    call InitVoid(CMB)

    do_metric = action == "m" .or. action == "b"
    do_geodesics = action == "g" .or. action == "b"

    if ( do_metric ) then
        call DumpMetric(6)
    end if

    if ( do_geodesics ) then
        call DumpGeodesics(6)
    end if

contains

    function GetCommandName()
        character(len=256) GetCommandName

        call get_command_argument(0, GetCommandName)

    end function GetCommandName

    function GetArgFloat(i)
        integer, intent(in) :: i
        real(kind(1.d0)) GetArgFloat
        character(len=64) :: arg

        call get_command_argument(i, arg)

        read(arg, *) GetArgFloat

    end function GetArgFloat

    subroutine DumpGeodesics(outfn)

        integer :: outfn, i, imax

        imax = size(VPNR%ztr(1,:))

        write(outfn, '(100A15)') "#1:z", "2:t", "3:r", "4:d_A(z)"
        do i = 1, imax

            write(outfn, '(100E15.6)') VPNR%ztr(1:3, i), VoidDA(VPNR%ztr(1, i))

        end do

    end subroutine DumpGeodesics

    subroutine DumpMetric(outfn)

        integer :: outfn, i, imax

        imax = size(VPNR%ztr(1,:))

        write(outfn, '(100A15)') "#1:z", "2:t", "3:r", "4:d_A(z)"
        do i = 1, imax

            write(outfn, '(100E15.6)') VPNR%ztr(1:3, i), VoidDA(VPNR%ztr(1, i))

        end do

    end subroutine DumpMetric

end program VoidDistances2020
