CREATE DATABASE YaYoBE_Hospital
GO

USE YaYoBE_Hospital
GO

CREATE TABLE Gender 
(
GenderId CHAR(1) PRIMARY KEY, GenderType VARCHAR(10), [Description] VARCHAR(MAX)
)

CREATE TABLE MaritalStatus 
(
MaritalStatusId TINYINT PRIMARY KEY, MaritalStatus VARCHAR(10), [Description] VARCHAR(MAX)
)

CREATE TABLE Religion 
(
ReligionId TINYINT PRIMARY KEY, Religion VARCHAR(30), [Description] VARCHAR(MAX)
)

CREATE TABLE Race
(
RaceId TINYINT PRIMARY KEY, Race VARCHAR(30), [Description] VARCHAR(MAX)
)

CREATE TABLE PatientType
(
PatientTypeId TINYINT PRIMARY KEY, PatientType VARCHAR(20), [Description] VARCHAR(MAX)
)

CREATE TABLE VisitStatus
(
VisitStatusId INT PRIMARY KEY, VisitStatus VARCHAR(50), [Description] VARCHAR(MAX)
)

CREATE TABLE FinClass
(
FinClassId INT PRIMARY KEY, FinClass VARCHAR(50), [Description] VARCHAR(MAX)
)

CREATE TABLE [Language]
(
LanguageId TINYINT PRIMARY KEY, [Language] VARCHAR(50),[Description] VARCHAR(MAX)
)

CREATE TABLE PatientAddress 
(
PatientAddressId INT IDENTITY PRIMARY KEY, PatientAddress VARCHAR(50),
City VARCHAR(50), [State]VARCHAR(2), ZipCode VARCHAR(5) CHECK(ZipCode LIKE '[0-9][0-9][0-9][0-9][0-9]'), Country VARCHAR(50),
Email VARCHAR(50) CHECK(Email LIKE '%@%.%'), CellPhone CHAR(12) CHECK(CellPhone LIKE '[0-9][0-9][0-9][ ][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'),
HomePhone CHAR(12) CHECK(HomePhone LIKE '[0-9][0-9][0-9][ ][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'),
OfficePhone CHAR(12) CHECK(OfficePhone LIKE '[0-9][0-9][0-9][ ][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]')
)

CREATE TABLE Patient
(
PatientId INT IDENTITY(10001,1) PRIMARY KEY,
FirstName VARCHAR(50), MiddleName VARCHAR(50), LastName VARCHAR(50), 
PatientAddressId INT FOREIGN KEY REFERENCES PatientAddress (PatientAddressId),
GenderId CHAR(1) FOREIGN KEY REFERENCES Gender (GenderId),
DOB DATE, Soc_Sec_No VARCHAR(11) CHECK (Soc_Sec_No LIKE '[0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9][0-9][0-9]'),
MaritalStatusId TINYINT FOREIGN KEY REFERENCES MaritalStatus (MaritalStatusId),
LanguageId TINYINT FOREIGN KEY REFERENCES Language(LanguageId),
ReligionId TINYINT FOREIGN KEY REFERENCES Religion(ReligionId),
RaceId TINYINT FOREIGN KEY REFERENCES Race(RaceId)
--InsuranceId INT FOREIGN KEY REFERENCES Insurance(InsuranceId)
)

CREATE TABLE PatientEmergencyContactPerson
(
PECPersonId INT IDENTITY PRIMARY KEY, PatientId INT FOREIGN KEY REFERENCES Patient(PatientId), EmergencyContactName VARCHAR(50), EmergencyContactPhoneNo CHAR(12) CHECK(EmergencyContactPhoneNo LIKE '[0-9][0-9][0-9][ ][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'),
RelationShipWithPatient VARCHAR(50)
)

CREATE TABLE ArrivedBy
(
ArrivedByID TINYINT IDENTITY PRIMARY KEY, ArrivedBy VARCHAR(50), [Description] VARCHAR(MAX)
)

CREATE TABLE Severity
(
SeverityId TINYINT IDENTITY PRIMARY KEY, Severity VARCHAR(50), [Description] VARCHAR(MAX)
)

CREATE TABLE PatientCategory
(
PatientCategoryId TINYINT IDENTITY PRIMARY KEY, PatientCategory VARCHAR(50), [Description] VARCHAR(MAX)
)

CREATE TABLE AdmissionService
(
AdmissionServiceId INT IDENTITY PRIMARY KEY, AdmissionService VARCHAR(100), [Description] VARCHAR(MAX)
)

CREATE TABLE Guaranter
(
GuaranterId VARCHAR(10) PRIMARY KEY, GuaranterFullName VARCHAR(50), GuarantorRank TINYINT, GuarantorAddress VARCHAR(100),
GuarantorPhone CHAR(12) CHECK(GuarantorPhone LIKE '[0-9][0-9][0-9][ ][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'), GuaranterLegal VARCHAR(50)
)

CREATE TABLE PointofOrigin
(
PointofOriginId INT PRIMARY KEY, PointofOrigin VARCHAR(50), [Description] VARCHAR(MAX)
)

CREATE TABLE DischargeStatus
(
DischargeStatusId TINYINT PRIMARY KEY, DischargeStatus VARCHAR(50), [Description] VARCHAR(MAX)
)

CREATE TABLE DischargeDestination
(
DischargeDestinationId TINYINT PRIMARY KEY, DischargeDestination VARCHAR(50), [Description] VARCHAR(MAX)
)

CREATE TABLE PayerVisitInt
(
PayerVisitIntId INT PRIMARY KEY, PayerVisitInt VARCHAR(50), [Description] VARCHAR(MAX)
)

CREATE TABLE Employee
(
EmpId INT IDENTITY PRIMARY KEY, FName VARCHAR(50), LName VARCHAR(50), Profession VARCHAR(50), 
StAddress VARCHAR (50), City VARCHAR(30), [State] CHAR(2), ZipCode CHAR(5) CHECK(ZipCode LIKE '[0-9][0-9][0-9][0-9][0-9]'),
Gender CHAR(1), Email VARCHAR(50) CHECK(Email LIKE '%@%.%'), Phone CHAR(12) CHECK(Phone LIKE '[0-9][0-9][0-9][ ][0-9][0-9][0-9][-][0-9][0-9][0-9][0-9]'),
Pager VARCHAR(50), SSN VARCHAR(11) CHECK (SSN LIKE '[0-9][0-9][0-9][-][0-9][0-9][-][0-9][0-9][0-9][0-9]'),
Position VARCHAR(50)
)

CREATE TABLE PhysicianRank
(
Rank TINYINT IDENTITY PRIMARY KEY, [Description] VARCHAR(30)
)

CREATE TABLE Physician
(
PhysicianId INT PRIMARY KEY FOREIGN KEY REFERENCES Employee(EmpId), LisenceNo VARCHAR(10),
LisenceDate DATE, Specialization VARCHAR(100), Rank TINYINT FOREIGN KEY REFERENCES PhysicianRank(Rank)
)

CREATE TABLE Nurse
(
NurseId INT PRIMARY KEY FOREIGN KEY REFERENCES Employee(EmpId), LisenceNo VARCHAR(10),
LisenceDate DATE, NurseType VARCHAR(100)
)

CREATE TABLE CNA
(
CNAId INT PRIMARY KEY FOREIGN KEY REFERENCES Employee(EmpId), LisenceNo VARCHAR(10),
LisenceDate DATE)

CREATE TABLE PharmacyPersonnel
(
PharmacistId INT PRIMARY KEY FOREIGN KEY REFERENCES Employee(EmpId), LisenceNo VARCHAR(10),
LisenceDate DATE, PCATTestResult VARCHAR(10), [Level] CHAR(5)
)

CREATE TABLE LabTechnician
(
LabTechId INT PRIMARY KEY FOREIGN KEY REFERENCES Employee(EmpId), LisenceNo VARCHAR(10),
LisenceDate DATE, LisenceExpDate DATE
)

CREATE TABLE Appointment
(
AppotNo INT PRIMARY KEY, PatientId INT FOREIGN KEY REFERENCES PAtient(PatientId),
PhysicianId INT FOREIGN KEY REFERENCES Physician(PhysicianId), ApptPlacedDate DATE, ApptDate DATE,
ReasonForAppointment VARCHAR(100), ExaminationRoom CHAR(5)
)

CREATE TABLE Patient_Admission
(
AdmissionId INT IDENTITY(10001,1) PRIMARY KEY, PatientId INT FOREIGN KEY REFERENCES Patient(PatientId), 
PatientTypeId TINYINT FOREIGN KEY REFERENCES PatientType(PatientTypeId),
PatientCategoryId TINYINT FOREIGN KEY REFERENCES PatientCategory(PatientCategoryId),
ArrivedByID TINYINT FOREIGN KEY REFERENCES ArrivedBy(ArrivedById),
SeverityId TINYINT FOREIGN KEY REFERENCES Severity(SeverityId),
AdmissionLocation VARCHAR(50),
AdmissionServiceId INT FOREIGN KEY REFERENCES AdmissionService(AdmissionServiceId),
VisitStatusId INT FOREIGN KEY REFERENCES VisitStatus(VisitStatusId),
FinClassId INT FOREIGN KEY REFERENCES FinClass(FinClassId),
AdmitDateAndTime DATETIME Default GETDATE(),
AdmissionComplaint VARCHAR(500),
GuaranterId VARCHAR(10) FOREIGN KEY REFERENCES Guaranter(GuaranterId),
PointofOriginId INT FOREIGN KEY REFERENCES PointofOrigin(PointofOriginId),
PayerVisitIntId INT FOREIGN KEY REFERENCES PayerVisitInt(PayerVisitIntId),
[Weight] DECIMAL(5,2), Height DECIMAL(4,2), ReasonForVisit VARCHAR(500),
AppointmentNo INT FOREIGN KEY REFERENCES Appointment(AppotNo),
[Description] VARCHAR(MAX)
)

CREATE TABLE Discharge
(
AdmissionId INT FOREIGN KEY REFERENCES Patient_Admission(AdmissionId),
DischargeStatusId TINYINT FOREIGN KEY REFERENCES DischargeStatus(DischargeStatusId),
DischargeDestinationId TINYINT FOREIGN KEY REFERENCES DischargeDestination(DischargeDestinationId),
DischargeDate DATE DEFAULT GETDATE(),
Discription VARCHAR(MAX)
)

   CREATE TABLE Billing	
   (	
	BillingId	INT,	
	AdmissionId	INT,	
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
	Primary key (BillingId),
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
  DiagnosisDescripition Varchar(50) not null,
  Primary key (DiagnosisCode),
  )

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

  ALTER TABLE Prescription
  ADD FOREIGN KEY (AdmissionId) REFERENCES Patient_Admission(AdmissionId)

  CREATE TABLE Patient_Diagnosis
  (
  PatientId INT PRIMARY KEY,
  DiagnosisCode VARCHAR(50) FOREIGN KEY REFERENCES Diagnosis(DiagnosisCode),
  [Description] VARCHAR(MAX)
  )