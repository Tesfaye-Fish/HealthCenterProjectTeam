 USE master
 IF EXISTS (SELECT NAME FROM sys.databases WHERE NAME='YaYoBE_Hospital1')
DROP DATABASE YaYoBE_Hospital1
GO

CREATE DATABASE YaYoBE_Hospital1
GO

USE YaYoBE_Hospital1
GO

CREATE TABLE Gender 
(
GenderId TINYINT PRIMARY KEY, GenderType VARCHAR(10) NOT NULL, [Description] VARCHAR(MAX)
)

--ALTER TABLE Gender
--ADD CONSTRAINT [PK__Gender__4E24E9F792A8C18F] PRIMARY KEY (GenderId)

--ALTER TABLE Gender
--ALTER COLUMN GenderId TINYINT NOT NULL

CREATE TABLE MaritalStatus 
(
MaritalStatusId TINYINT PRIMARY KEY, MaritalStatus VARCHAR(10) NOT NULL, [Description] VARCHAR(MAX)
)

CREATE TABLE Religion 
(
ReligionId TINYINT PRIMARY KEY, Religion VARCHAR(30) NOT NULL, [Description] VARCHAR(MAX)
)

CREATE TABLE Race
(
RaceId TINYINT PRIMARY KEY, Race VARCHAR(30) NOT NULL, [Description] VARCHAR(MAX)
)

CREATE TABLE PatientType
(
PatientTypeId TINYINT PRIMARY KEY, PatientType VARCHAR(20) NOT NULL, [Description] VARCHAR(MAX)
)

CREATE TABLE VisitStatus
(
VisitStatusId INT PRIMARY KEY, VisitStatus VARCHAR(50) NOT NULL, [Description] VARCHAR(MAX)
)

CREATE TABLE FinClass
(
FinClassId INT PRIMARY KEY, FinClass VARCHAR(50) NOT NULL, [Description] VARCHAR(MAX)
)

CREATE TABLE [Language]
(
LanguageId TINYINT PRIMARY KEY, [Language] VARCHAR(50) NOT NULL, [Description] VARCHAR(MAX)
)

CREATE TABLE PatientAddress 
(
PatientAddressId INT IDENTITY PRIMARY KEY, PatientAddress VARCHAR(50),
City VARCHAR(50) NOT NULL, [State]VARCHAR(2) NOT NULL, ZipCode VARCHAR(5) CHECK(ZipCode LIKE '[0-9][0-9][0-9][0-9][0-9]') NOT NULL, Country VARCHAR(50) NOT NULL,
Email VARCHAR(50) CHECK(Email LIKE '%@%.%'), CellPhone CHAR(12) CHECK(CellPhone LIKE '[0-9][0-9][0-9][ ][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'),
HomePhone CHAR(12) CHECK(HomePhone LIKE '[0-9][0-9][0-9][ ][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'),
OfficePhone CHAR(12) CHECK(OfficePhone LIKE '[0-9][0-9][0-9][ ][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]')
)

CREATE TABLE Patient
(
ID INT IDENTITY,
MRNo AS ('MRN'+ LEFT(LastName, 1) + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8)) PERSISTED PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL, MiddleName VARCHAR(50), LastName VARCHAR(50)NOT NULL, 
PatientAddressId INT FOREIGN KEY REFERENCES PatientAddress (PatientAddressId) NOT NULL,
GenderId TINYINT FOREIGN KEY REFERENCES Gender(GenderId),
DOB DATE NOT NULL, Soc_Sec_No VARCHAR(11) CHECK (Soc_Sec_No LIKE '[0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9][0-9][0-9]'),
MaritalStatusId TINYINT FOREIGN KEY REFERENCES MaritalStatus (MaritalStatusId),
LanguageId TINYINT FOREIGN KEY REFERENCES Language(LanguageId),
ReligionId TINYINT FOREIGN KEY REFERENCES Religion(ReligionId),
RaceId TINYINT FOREIGN KEY REFERENCES Race(RaceId)
--InsuranceId INT FOREIGN KEY REFERENCES Insurance(InsuranceId)
)

--ALTER TABLE PATIENT
--ADD CONSTRAINT [FK__Patient__GenderI__45F365D3] FOREIGN KEY (GenderId) REFERENCES Gender(GenderId)

--ALTER TABLE Patient
--ALTER COLUMN GenderId TINYINT

CREATE TABLE PatientEmergencyContactPerson
(
PECPersonId INT IDENTITY PRIMARY KEY, MRNo VARCHAR(12) FOREIGN KEY REFERENCES Patient(MRNo), EmergencyContactName VARCHAR(50), EmergencyContactPhoneNo CHAR(12) CHECK(EmergencyContactPhoneNo LIKE '[0-9][0-9][0-9][ ][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'),
RelationShipWithPatient VARCHAR(50)
)


CREATE TABLE ArrivedBy
(
ArrivedByID TINYINT IDENTITY PRIMARY KEY, ArrivedBy VARCHAR(50) NOT NULL, [Description] VARCHAR(MAX)
)

CREATE TABLE Severity
(
SeverityId TINYINT IDENTITY PRIMARY KEY, Severity VARCHAR(50) NOT NULL, [Description] VARCHAR(MAX)
)

CREATE TABLE PatientCategory
(
PatientCategoryId TINYINT IDENTITY PRIMARY KEY, PatientCategory VARCHAR(50) NOT NULL, [Description] VARCHAR(MAX)
)

CREATE TABLE AdmissionService
(
AdmissionServiceId INT IDENTITY PRIMARY KEY, AdmissionService VARCHAR(100) NOT NULL, [Description] VARCHAR(MAX)
)

CREATE TABLE Guaranter
(
GuaranterId VARCHAR(10) PRIMARY KEY, GuaranterFullName VARCHAR(50) NOT NULL, GuarantorRank TINYINT, GuarantorAddress VARCHAR(100),
GuarantorPhone CHAR(12) CHECK(GuarantorPhone LIKE '[0-9][0-9][0-9][ ][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'), GuaranterLegal VARCHAR(50)
)

CREATE TABLE PointofOrigin
(
PointofOriginId INT PRIMARY KEY, PointofOrigin VARCHAR(50) NOT NULL, [Description] VARCHAR(MAX)
)

CREATE TABLE DischargeStatus
(
DischargeStatusId TINYINT PRIMARY KEY, DischargeStatus VARCHAR(50) NOT NULL, [Description] VARCHAR(MAX)
)

CREATE TABLE DischargeDestination
(
DischargeDestinationId TINYINT PRIMARY KEY, DischargeDestination VARCHAR(50), [Description] VARCHAR(MAX)
)

CREATE TABLE PayerVisitInt
(
PayerVisitIntId INT PRIMARY KEY, PayerVisitInt VARCHAR(50) NOT NULL, [Description] VARCHAR(MAX)
)

CREATE TABLE Employee
(
EmpId INT IDENTITY PRIMARY KEY, FName VARCHAR(50) NOT NULL, LName VARCHAR(50) NOT NULL, Profession VARCHAR(50), 
StAddress VARCHAR (50) NOT NULL, City VARCHAR(30) NOT NULL, [State] CHAR(2) NOT NULL, ZipCode CHAR(5) CHECK(ZipCode LIKE '[0-9][0-9][0-9][0-9][0-9]') NOT NULL,
Gender CHAR(1), Email VARCHAR(50) CHECK(Email LIKE '%@%.%') NOT NULL, Phone CHAR(12) CHECK(Phone LIKE '[0-9][0-9][0-9][ ][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]') NOT NULL,
Pager VARCHAR(50), SSN VARCHAR(11) CHECK (SSN LIKE '[0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9][0-9][0-9]'),
Position VARCHAR(50)
)

CREATE TABLE PhysicianRank
(
[Rank] TINYINT IDENTITY PRIMARY KEY, RankName VARCHAR(50) NOT NULL, [Description] VARCHAR(30)
)

CREATE TABLE Physician
(
PhysicianId INT PRIMARY KEY FOREIGN KEY REFERENCES Employee(EmpId), LisenceNo VARCHAR(10) NOT NULL,
LisenceDate DATE NOT NULL, Specialization VARCHAR(100) NOT NULL, [Rank] TINYINT FOREIGN KEY REFERENCES PhysicianRank([Rank])
)

CREATE TABLE Nurse
(
NurseId INT PRIMARY KEY FOREIGN KEY REFERENCES Employee(EmpId), LisenceNo VARCHAR(10) NOT NULL,
LisenceDate DATE NOT NULL, NurseType VARCHAR(100)
)

CREATE TABLE CNA
(
CNAId INT PRIMARY KEY FOREIGN KEY REFERENCES Employee(EmpId), LisenceNo VARCHAR(10) NOT NULL,
LisenceDate DATE)

CREATE TABLE PharmacyPersonnel
(
PharmacistId INT PRIMARY KEY FOREIGN KEY REFERENCES Employee(EmpId), LisenceNo VARCHAR(10) NOT NULL,
LisenceDate DATE NOT NULL, PCATTestResult VARCHAR(10), [Level] CHAR(5)
)

CREATE TABLE LabTechnician
(
LabTechId INT PRIMARY KEY FOREIGN KEY REFERENCES Employee(EmpId), LisenceNo VARCHAR(10) NOT NULL,
LisenceDate DATE NOT NULL, LisenceExpDate DATE
)

CREATE TABLE Appointment
(
AppotNo INT PRIMARY KEY, MRNo VARCHAR(12) FOREIGN KEY REFERENCES Patient(MRNo) NOT NULL,
PhysicianId INT FOREIGN KEY REFERENCES Physician(PhysicianId), ApptPlacedDate DATE DEFAULT GETDATE(), ApptDate DATE,
ReasonForAppointment VARCHAR(100), ExaminationRoom CHAR(5)
)

CREATE TABLE Patient_Admission
(
AdmissionId INT IDENTITY(10001,1) PRIMARY KEY, 
MRNO VARCHAR(12) FOREIGN KEY REFERENCES Patient(MRNo) NOT NULL, 
PatientTypeId TINYINT FOREIGN KEY REFERENCES PatientType(PatientTypeId) NOT NULL,
PatientCategoryId TINYINT FOREIGN KEY REFERENCES PatientCategory(PatientCategoryId),
ArrivedByID TINYINT FOREIGN KEY REFERENCES ArrivedBy(ArrivedById),
SeverityId TINYINT FOREIGN KEY REFERENCES Severity(SeverityId),
AdmissionLocation VARCHAR(50),
AdmissionServiceId INT FOREIGN KEY REFERENCES AdmissionService(AdmissionServiceId),
VisitStatusId INT FOREIGN KEY REFERENCES VisitStatus(VisitStatusId) NOT NULL,
FinClassId INT FOREIGN KEY REFERENCES FinClass(FinClassId),
AdmitDateAndTime DATETIME Default GETDATE(),
GuaranterId VARCHAR(10) FOREIGN KEY REFERENCES Guaranter(GuaranterId) DEFAULT 'Self',
PointofOriginId INT FOREIGN KEY REFERENCES PointofOrigin(PointofOriginId),
PayerVisitIntId INT FOREIGN KEY REFERENCES PayerVisitInt(PayerVisitIntId),
[Weight] DECIMAL(5,2), Height DECIMAL(4,2), ReasonForVisit VARCHAR(500),
AppointmentNo INT FOREIGN KEY REFERENCES Appointment(AppotNo),
LegalStatusId INT foreign key references LegalStatus(LegalStatusId),
AdmissionComplaint VARCHAR(500),
[Description] VARCHAR(MAX)
)

CREATE TABLE Discharge
(
AdmissionId INT PRIMARY KEY FOREIGN KEY REFERENCES Patient_Admission(AdmissionId),
DischargeStatusId TINYINT FOREIGN KEY REFERENCES DischargeStatus(DischargeStatusId) NOT NULL,
DischargeDestinationId TINYINT FOREIGN KEY REFERENCES DischargeDestination(DischargeDestinationId),
DischargeDate DATE DEFAULT GETDATE(),
Discription VARCHAR(MAX)
)

   CREATE TABLE Billing	
   (	
	BillingId INT PRIMARY KEY,	
	AdmissionId	INT NULL,	
	BillingInvoice varchar(50) not null ,	
	BillingStatusId	Int not null,
	BillingPatientTypeID Int not null,	
	BillingPlan	Varchar(50) not null,
	BillingService Varchar(50) not null,	
	BilledAmt Varchar(50) not null,	
	BillingServiceFrom	Datetime not null,	
	BillingServiceThru	Datetime not null,	
	BillingType	Varchar(50)not null,	
	BillingAgency varchar(50)  not null,	
	BillingDate	Datetime not null,	
	BillingLastStatmentDate	Datetime not null,	
	BillingLastPaymentDate	Datetime not null,	
	BillingChargeAmt Decimal(9,3) not null,	
	BillingInsPmtAmt Decimal not null,	
	BillingPatPmtAmt Decimal not null,	
	BillingPatAdjAmt Decimal not null,	
	BillingTotalPmtAdjAmt Decimal not null,	
	BillingPmtsAdjsRecvd Decimal not null,	
	BillingCoInsAmt	Decimal not null,	
	BillingDedAmt Decimal not null,	
	BillingCurrentBalance Decimal not null,
	BillingVisitintId Int not null,
	BillingIvointId  Int not null,
    Foreign Key(AdmissionId)references Patient_Admission(AdmissionId),
	--Foreign Key(BillingStatusID)references BillingStatus (BillingStatusId),
	--Foreign Key(BillingPatientTypeID)references BillingType (BillingPatientTypeId),
	)
  
  CREATE TABLE Payer 
  ( 
  PayorVisitintId Varchar(50),
  PayorRank Varchar(50) Not null,
  payor Varchar (50) not null,
  Payorplan Varchar (50) not null,
  payorVerified Varchar (50) not null,
  payorEffectDate Varchar (50) not null,
  payorEndDate Varchar (50) not null,
  payorPhone Varchar (50) not null,
  payorplanSatisfied Varchar (50) not null,
  Primary Key (PayorVisitIntId)
  )

  Create table Diagnosis
  (
  DiagnosisCode Varchar(50),
  DiagnosisName Varchar(50) not null,
  [Description] VARCHAR(MAX),
  Primary key (DiagnosisCode)
  )

  --ALTER TABLE Diagnosis
  --ADD [Description] VARCHAR(MAX)

  Create table DiagComplication
 (
  DiagComNo Int,
  DiagCode Varchar(50) not null,
  DiagComplication Varchar(50) not null,
  Description Varchar(100) not null,
  Primary Key (DiagComNo),
  Foreign Key(DiagCode)references Diagnosis(DiagnosisCode),
 )

  Create table DiagInfection
 (
  DiagInfNo Int, 
  DiagCode Varchar(50) not null,
  Diaginfection Varchar(50) not null,
  Discription Varchar(100) not null,
 Primary Key (DiagInfNo),
 Foreign Key(DiagCode)references Diagnosis(DiagnosisCode)
 )
 
 Create table Prescription 
  (
  PrescriptionNo Int,
  AdmissionId Int Not null,
  DiagCode Varchar(50) not null,
  prescribedMedicine Varchar(50) not null,
  PrescribedAmount Decimal Not null,
  Dosage Varchar(50) not null,
  PrescribedDate Datetime not null,
  Primary Key (PrescriptionNo),
  Foreign Key(DiagCode)references Diagnosis(DiagnosisCode),
  FOREIGN KEY(AdmissionId) REFERENCES Patient_Admission(AdmissionId)
  )

  CREATE TABLE Patient_Diagnosis
  (
  MRNo VARCHAR(12) FOREIGN KEY REFERENCES Patient(MRNo),
  DiagnosisCode VARCHAR(50) FOREIGN KEY REFERENCES Diagnosis(DiagnosisCode),
  DiagTypeId INT FOREIGN KEY REFERENCES DiagnosisType(DiagTypeNo),
  PhysicianId INT FOREIGN KEY REFERENCES Physician(PhysicianId),
  LabTestId INT FOREIGN KEY REFERENCES LabDiag(LabTestId),
  DiagDate DATE,
  DiagRank INT,
  [Description] VARCHAR(MAX),
  PRIMARY KEY (MRNo, DiagnosisCode)
  )
  
  CREATE TABLE DiagnosisType 
  (DiagTypeNo INT PRIMARY KEY,
   DiagType VARCHAR(50),
   [Description] VARCHAR(MAX)
   )

   CREATE TABLE LabDiag
   (
   LabTestId INT PRIMARY KEY,
   MRNo VARCHAR(12) FOREIGN KEY REFERENCES Patient(MRNo),
   DiagCode VARCHAR(50) FOREIGN KEY REFERENCES Diagnosis(DiagnosisCode),
   LabTechId INT FOREIGN KEY REFERENCES LabTechnician(LabTechId),
   LabStationNo INT FOREIGN KEY REFERENCES LabStation(LabStNo),
   TestResult VARCHAR(100),
   LabRequestDate DATE,
   LabTest DATE DEFAULT GETDATE()
   )


   CREATE TABLE LabStation
   (
   LabStNo INT PRIMARY KEY,
   LabName VARCHAR(50),
   RoomNo INT FOREIGN KEY REFERENCES Room(RoomNo)
   )

