
      SUBROUTINE CNVT_LAI(GDNAM,LAITXTF,LAIS46)
!***********************************************************************
!  This subroutine converts LAI txt to LAI IOAPI
!
!  Called by TXT2IOAPI
!
!  Call:
!     PARSLINE
!     CHECKMEM
!
!  Created by Tan  07/07/2011 for MEGAN v2.10
!
!  History:
!***********************************************************************

      IMPLICIT NONE

C...........   INCLUDES:
      INCLUDE 'PARMS3.EXT'    !  I/O API parameters
      INCLUDE 'IODECL3.EXT'   !  I/O API function declarations
      INCLUDE 'FDESC3.EXT'    !  I/O API file description data structures

      INCLUDE 'LAI_MGN.EXT'   !  LAI

C...........   EXTERNAL FUNCTIONS and their descriptions:
      INTEGER      PROMPTFFILE, STR2INT
      REAL         STR2REAL
      LOGICAL      DSCGRID
      INTEGER      INDEX1
      EXTERNAL     PROMPTFFILE, DSCGRID
     &             STR2INT, STR2REAL, INDEX1

C.........  LOCAL VARIABLES and their descriptions:
      INTEGER       IOS            ! i/o status
      INTEGER       ILINE          ! current line
      INTEGER       ADEV           ! unit no. for input data file
      INTEGER       I, J, S, N     ! Counters
      INTEGER       ITIME          ! Counters
      INTEGER       IDATE          ! Counters
      CHARACTER*16    CNAME        ! Coord name
      CHARACTER(LEN=1000) LINE     ! input ine buffer
      CHARACTER*256    MESG        ! message buffer
      INTEGER       CID, INX, INY  ! Input grid x and y

      CHARACTER*16  :: LAITXTF
      CHARACTER*16  :: LAIS46
      CHARACTER*16  :: GDNAM

      ! CID, I, J, 46 LAIs
      INTEGER, PARAMETER :: MXTCOL = 49      ! Columns in an input line
      CHARACTER*30     SEGMENT( MXTCOL )     ! Input line fields

      INTEGER, PARAMETER :: NFLD  = MXTCOL-3 ! Number of output variables
      INTEGER          XREF(NFLD)
      INTEGER       :: NSTEP = NFLD
      INTEGER, PARAMETER :: NVARS = 1        ! Number of output variables

      REAL, ALLOCATABLE :: IBUFF( :, :, : )  ! input, output buffer

      CHARACTER*16  :: PROGNAME = 'CNVT_LAI'
      integer :: idum

!***********************************************************************
!... Begin program

!... Get output file grid parameters
      GDNAM3D = GDNAM
      IF( .NOT. DSCGRID( GDNAM3D, CNAME, GDTYP3D,
     &              P_ALP3D, P_BET3D, P_GAM3D, XCENT3D, YCENT3D,
     &              XORIG3D, YORIG3D, XCELL3D, YCELL3D,
     &              NCOLS3D, NROWS3D, NTHIK3D ) ) THEN
         MESG = 'Could not get grid description.'
         CALL M3EXIT ( PROGNAME, 0, 0, MESG, 2 )
      ENDIF

!... Allocate memory
      ALLOCATE ( IBUFF( NCOLS3D, NROWS3D, NSTEP ),
     &           STAT = IOS )
      CALL CHECKMEM ( IOS, 'IBUFF', PROGNAME )
      IBUFF = 0.

!... Get input file unit
      MESG = 'Enter logical name of LAI data file.'
      ADEV = PROMPTFFILE( MESG, .TRUE., .TRUE., LAITXTF, PROGNAME )
      IF( ADEV < 0 ) THEN
         MESG = 'Error opening input LAI file.'
         CALL M3EXIT ( PROGNAME, 0, 0, MESG, 2 )
      ENDIF

!... Read TXT input file
      ILINE = 0
      DO
         READ( ADEV, 1000, IOSTAT = IOS ) LINE
         ILINE = ILINE + 1
         IF( IOS < 0 ) EXIT       ! End of file, exit loop
         IF( LINE == ' ' ) CYCLE  ! Skip blank line
         IF( IOS > 0 ) THEN
            WRITE( MESG, 1010 ) 'I/O error', IOS,
     &            'reading input file at line', ILINE
            CALL M3EXIT( PROGNAME, 0, 0, MESG, 2 )
         ENDIF

         CALL PARSLINE( LINE, MXTCOL, SEGMENT )  ! break lines into segments
         IF ( ILINE .EQ. 1 ) THEN
            DO S = 1 , NFLD
               MESG = SEGMENT( S + 3 )
               CALL UPCASE( MESG )  ! to all caps
               IF ( INDEX1(TRIM( MESG ),N_MGN_LAI ,MGN_LAI) .NE. 0) THEN
                  N = INDEX1(TRIM( MESG ),N_MGN_LAI ,MGN_LAI)
                  XREF( S ) = N
               ELSE
                  WRITE(*,*) MESG//' is not valid'
                  STOP
               ENDIF
               PRINT*,'READ ',MGN_LAI(N)
            ENDDO
            CYCLE  ! go back to read 2nd line
         ENDIF

         CID = STR2INT( SEGMENT(1) )   ! convert character to integer
         INX = STR2INT( SEGMENT(2) )   ! convert character to integer
         INY = STR2INT( SEGMENT(3) )   ! convert character to integer
         DO S = 1, NFLD
            IBUFF(INX,INY,XREF(S)) = STR2REAL( SEGMENT( 3+S ) )  ! convert char to real
         ENDDO
      ENDDO

      WRITE( MESG, 1010 ) 'Total number of input lines read:',ILINE
      CALL M3MESG( MESG )

!... Setup additional outfile parameters and open outfile
      FTYPE3D = GRDDED3
      NVARS3D = NVARS
!... Set VNAME3D and UNITS3D
      DO N = 1,NVARS
        VNAME3D( N ) = 'LAIS'
        UNITS3D( N ) = 'nondimension'
      ENDDO
      VTYPE3D(1:NVARS) = M3REAL
      TSTEP3D = 10000
      MXREC3D = NSTEP            ! 46 LAI
      NLAYS3D = 1
      CALL NAMEVAL ( LAITXTF, MESG )  ! get input file name
      FDESC3D( 1 ) = 'Converted from MEGAN input text file: '
      FDESC3D( 2 ) = TRIM(MESG)
      IF ( .NOT. OPEN3( LAIS46, FSCREA3, PROGNAME ) ) THEN
           MESG = 'Could not open file "'//TRIM(LAIS46)//'" for output'
           CALL M3EXIT( PROGNAME, 0, 0, MESG, 2 )
      ENDIF

!... Write output
      IDATE = 0
      ITIME = 0
      DO S = 1, NSTEP
         PRINT*,'Min value for '//MGN_LAI(S)//':',MINVAL(IBUFF(:,:,S))
         PRINT*,'Max value for '//MGN_LAI(S)//':',MAXVAL(IBUFF(:,:,S))
         IF ( .NOT. WRITE3(LAIS46,ALLVAR3,IDATE,ITIME,IBUFF(:,:,S))) THEN
            MESG = 'Error writing to  file "'//TRIM(LAIS46)//'"'
            CALL M3EXIT(PROGNAME,0,0,MESG,2)
         ENDIF
         IDUM = 0
         CALL NEXTIME( IDUM , ITIME, TSTEP3D )
         IF ( ITIME .EQ. 0 ) IDATE = 1
      ENDDO

      IF ( CLOSE3(LAIS46) ) THEN
        CALL M3MESG( 'Closing LAI IOAPI file')
      ENDIF
      CLOSE(ADEV)

1000  FORMAT( 40A )
1010  FORMAT( 40( A, :, I8, :, 1X ) )

      END SUBROUTINE
