#### Preamble ####
# Purpose: Clenas the results of Toronto Citizens' Climate Change Perception
# Author: Aamishi Avarsekar
# Date: 24th September 2024
# Contact: aamishi.avarsekar@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(dplyr)

#### Clean data ####
raw_data <- read_csv("data/raw_data/raw_data.csv")

# Manually renaming specific columns
simplified_data_01 <- raw_data %>%
  rename(
    ParticipantID = Participant.ID,
    CouncilBudget = X1..I.think.City.Council.should.consider.increasing.the.budget.for.the.following.service..select.one..,
    EnvSupport = X2.1.Supports.environmental.and.climate.action,
    TruthJustice = X2.2.Supports.truth..justice.and.reconciliation,
    EquitableAccess = X2.3.Makes.sure.everyone.in.Toronto.has.equitable.access.to.services.and.supports,
    EasierTravel = X2.4.Makes.it.easier.to.get.around,
    WellBeing = X2.5.Supports.social..physical.and.mental.well.being,
    AffordableLife = X2.6.Makes.life.easier.or.more.affordable,
    EconomySupport = X2.7.Helps.build.the.economy..supports.businesses..job.creation.or.employment,
    Safety = X2.8.Makes.Toronto.safer,
    CityDevelopment = X2.9.Supports.the.city.s.development.and.prepares.for.future.growth,
    MunicipalService = X2.10.This.is.a.fundamental.municipal.service,
    TaxEfficiency = X2.11.Is.a.good.use.of.my.property.taxes.or.user.fees,
    OtherOption = X2.12.Other.,
    OtherText = X2.13.Other.Text,
    DecreaseFunding = X3..The.service.I.think.the.City.should.decrease.funding.to.is.,
    RedirectFunds = X4.1.The.money.should.go.to.another.program.or.service,
    AlreadyFunded = X4.2.Enough.of.my.money.goes.to.this.service.already,
    UnequalBenefits = X4.3.Benefits.some.Toronto.residents.more.than.others,
    OtherGovFunding = X4.4.The.money.to.support.it.should.come.from.another.level.of.government,
    NoLongerNeeded = X4.5.The.City.should.not.deliver.this.service.anymore,
    ImproveEfficiency = X4.6.It.needs.to.be.more.effective.before.the.City.spends.more.money.on.this.service,
    NoLongerMeetsNeeds = X4.7.It.no.longer.meets.the.needs.of.Toronto.s.residents,
    OtherReason = X4.8.Other.,
    OtherReasonText = X4.9.Other.Text,
    ProvincialResp = X5..The.City.continues.to.fill.the.funding.gap.for.services.that.are.the.Provincial.Government.s.responsibilities..resulting.in.a..1.5.billion.budget.shortfall..These.services.should.be.properly.funded.by.them.including.housing..emergency.shelters..highways..public.safety..refugees.and.transit..Do.you.agree.that.the.provincial.government.should.step.up.and.pay.for.their.responsibilities.,
    FederalResp = X6..The.City.of.Toronto.continues.to.fill.the.gap.in.funding.for.services.that.are.within.the.Federal.Government.s.responsibilities.and.should.be.properly.funded.by.them..These.services.include.housing..transit..health.and.refugee.settlement....Do.you.agree.that.the.federal.government.should.step.up.and.pay.for.their.responsibilities.,
    LocalMPContact = X7.1.Meet.and.speak.with.my.local.Member.of.Provincial.Parliament..MPP..and.Member.of.Parliament..MP.,
    FriendsContactMP = X7.2.Ask.friends.to.also.contact.their.MPP.and.MP.to.support.a.New.Deal,
    ProvincialConsultations = X7.3.Participate.in.the.provincial.budget.consultations,
    FederalConsultations = X7.4.Participate.in.the.federal.budget.consultations,
    Petition = X7.5.Sign.a.petition.to.the.provincial.and.federal.parliaments,
    OtherAction = X7.6.Other,
    OtherActionText = X7.7.Other.Text,
    PostalCode = X8..Please.provide.the.first.three.characters.of.your.postal.code..e.g..M5H.,
    Age = X9..What.is.your.age.,
    Indigenous = X10.1.Identify.as.Indigenous.to.Canada..First.Nations..Inuit.or.Metis.,
    Racialized = X10.2.From.a.racialized.community,
    NewToCanada = X10.3.New.to.Canada..less.than.5.years.,
    HomelessExperience = X10.4.Have.lived.experience.of.homelessness,
    LGBTQ = X10.5.Member.of.the.2SLGBTQ..community,
    Disabled = X10.6.Living.with.disability,
    LowIncome = X10.7.Low.income,
    NonEnglishFrench = X10.8.My.primary.language.is.not.English.or.French,
    NoneApply = X10.9.None.of.these.apply.to.me.or.prefer.not.to.answer,
    OtherDemographics = X10.10.Other,
    OtherDemographicsText = X10.11.Other.Text
  )

simplified_data_02 <- simplified_data_01 %>%
  mutate(
    CouncilBudget = replace_na(CouncilBudget, "None"),
    DecreaseFunding = replace_na(DecreaseFunding, "None"), 
    ProvincialResp = replace_na(ProvincialResp, "None"), 
    FederalResp = replace_na(FederalResp, "None")
    ) %>%
  mutate(
    across(where(is.numeric), ~ replace_na(.x, 0))
  )

simplified_data_03<- simplified_data_02 %>%
  select(-OtherText, -OtherReasonText, -OtherActionText, -OtherDemographicsText)

simplified_data_04_no_demo <- simplified_data_03 %>%
  select(-PostalCode, -Age, -Indigenous, -Racialized, -NewToCanada, -HomelessExperience, 
          -LGBTQ, -Disabled, -LowIncome, -NonEnglishFrench, -NoneApply, -OtherDemographics)

simplified_data_04_no_na <- simplified_data_03 %>%
  drop_na()


#### Save data ####
write_csv(cleaned_data, "outputs/data/analysis_data.csv")
