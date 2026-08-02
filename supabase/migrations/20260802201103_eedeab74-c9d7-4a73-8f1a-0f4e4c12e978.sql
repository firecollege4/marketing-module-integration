
CREATE TABLE public.marketing_campaigns (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code text NOT NULL UNIQUE,
  name text NOT NULL,
  channel text NOT NULL,
  objective text NOT NULL DEFAULT 'Lead Generation',
  status text NOT NULL DEFAULT 'draft',
  start_date date NOT NULL,
  end_date date NOT NULL,
  budget numeric NOT NULL DEFAULT 0,
  spend numeric NOT NULL DEFAULT 0,
  impressions bigint NOT NULL DEFAULT 0,
  clicks bigint NOT NULL DEFAULT 0,
  conversions bigint NOT NULL DEFAULT 0,
  leads bigint NOT NULL DEFAULT 0,
  revenue numeric NOT NULL DEFAULT 0,
  kpi_target text,
  region text,
  owner text,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE public.marketing_ad_groups (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  campaign_id uuid REFERENCES public.marketing_campaigns(id) ON DELETE CASCADE,
  name text NOT NULL,
  level text NOT NULL DEFAULT 'ad_group',
  platform text NOT NULL,
  status text NOT NULL DEFAULT 'active',
  budget numeric NOT NULL DEFAULT 0,
  spend numeric NOT NULL DEFAULT 0,
  impressions bigint NOT NULL DEFAULT 0,
  clicks bigint NOT NULL DEFAULT 0,
  conversions bigint NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE public.marketing_creatives (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  asset_type text NOT NULL,
  format text NOT NULL,
  campaign_id uuid REFERENCES public.marketing_campaigns(id) ON DELETE SET NULL,
  status text NOT NULL DEFAULT 'draft',
  dimensions text,
  tags text[] NOT NULL DEFAULT '{}',
  uploaded_by text,
  performance_score numeric NOT NULL DEFAULT 0,
  usage_count integer NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE public.marketing_content_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  content_type text NOT NULL,
  channel text NOT NULL,
  status text NOT NULL DEFAULT 'draft',
  scheduled_for timestamptz,
  author text,
  body text,
  tags text[] NOT NULL DEFAULT '{}',
  word_count integer NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE public.marketing_seo_keywords (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  keyword text NOT NULL,
  page_url text,
  position integer NOT NULL DEFAULT 0,
  previous_position integer NOT NULL DEFAULT 0,
  search_volume integer NOT NULL DEFAULT 0,
  difficulty integer NOT NULL DEFAULT 0,
  cpc numeric NOT NULL DEFAULT 0,
  intent text NOT NULL DEFAULT 'commercial',
  status text NOT NULL DEFAULT 'tracking',
  country text NOT NULL DEFAULT 'India',
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE public.marketing_seo_pages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  url text NOT NULL,
  title text NOT NULL,
  meta_description text,
  health_score integer NOT NULL DEFAULT 0,
  issues integer NOT NULL DEFAULT 0,
  backlinks integer NOT NULL DEFAULT 0,
  organic_traffic integer NOT NULL DEFAULT 0,
  indexed boolean NOT NULL DEFAULT true,
  last_crawled timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE public.marketing_lead_sources (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  source_type text NOT NULL,
  channel text NOT NULL,
  leads_count integer NOT NULL DEFAULT 0,
  qualified_count integer NOT NULL DEFAULT 0,
  conversion_rate numeric NOT NULL DEFAULT 0,
  cost_per_lead numeric NOT NULL DEFAULT 0,
  status text NOT NULL DEFAULT 'active',
  region text,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE public.marketing_leads (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  full_name text NOT NULL,
  email text,
  phone text,
  company text,
  source_id uuid REFERENCES public.marketing_lead_sources(id) ON DELETE SET NULL,
  campaign_id uuid REFERENCES public.marketing_campaigns(id) ON DELETE SET NULL,
  score integer NOT NULL DEFAULT 0,
  stage text NOT NULL DEFAULT 'new',
  status text NOT NULL DEFAULT 'open',
  city text,
  state text,
  assigned_to text,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE public.marketing_offers (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  festival text,
  offer_type text NOT NULL DEFAULT 'discount',
  discount_percent numeric NOT NULL DEFAULT 0,
  code text,
  start_date date NOT NULL,
  end_date date NOT NULL,
  status text NOT NULL DEFAULT 'scheduled',
  regions text[] NOT NULL DEFAULT '{}',
  redemptions integer NOT NULL DEFAULT 0,
  revenue numeric NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE public.marketing_locations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  location_type text NOT NULL DEFAULT 'city',
  country text NOT NULL DEFAULT 'India',
  state text,
  city text,
  radius_km integer NOT NULL DEFAULT 0,
  population integer NOT NULL DEFAULT 0,
  active_campaigns integer NOT NULL DEFAULT 0,
  spend numeric NOT NULL DEFAULT 0,
  leads integer NOT NULL DEFAULT 0,
  status text NOT NULL DEFAULT 'active'
);

CREATE TABLE public.marketing_schedules (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  campaign_id uuid REFERENCES public.marketing_campaigns(id) ON DELETE CASCADE,
  title text NOT NULL,
  channel text NOT NULL,
  scheduled_at timestamptz NOT NULL,
  recurrence text NOT NULL DEFAULT 'once',
  status text NOT NULL DEFAULT 'scheduled',
  owner text
);

CREATE TABLE public.marketing_channel_performance (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  channel text NOT NULL,
  period_start date NOT NULL,
  period_end date NOT NULL,
  spend numeric NOT NULL DEFAULT 0,
  impressions bigint NOT NULL DEFAULT 0,
  clicks bigint NOT NULL DEFAULT 0,
  conversions bigint NOT NULL DEFAULT 0,
  revenue numeric NOT NULL DEFAULT 0,
  roas numeric NOT NULL DEFAULT 0
);

CREATE TABLE public.marketing_kpi_snapshots (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  metric_date date NOT NULL UNIQUE,
  spend numeric NOT NULL DEFAULT 0,
  reach bigint NOT NULL DEFAULT 0,
  impressions bigint NOT NULL DEFAULT 0,
  clicks bigint NOT NULL DEFAULT 0,
  leads integer NOT NULL DEFAULT 0,
  conversions integer NOT NULL DEFAULT 0,
  revenue numeric NOT NULL DEFAULT 0,
  roas numeric NOT NULL DEFAULT 0,
  conversion_rate numeric NOT NULL DEFAULT 0
);

CREATE TABLE public.marketing_approvals (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  item_type text NOT NULL,
  item_name text NOT NULL,
  requested_by text NOT NULL,
  requested_at timestamptz NOT NULL DEFAULT now(),
  status text NOT NULL DEFAULT 'pending',
  priority text NOT NULL DEFAULT 'medium',
  approver text,
  notes text,
  decided_at timestamptz
);

CREATE TABLE public.marketing_reports (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  report_type text NOT NULL,
  period text NOT NULL,
  generated_at timestamptz NOT NULL DEFAULT now(),
  generated_by text,
  format text NOT NULL DEFAULT 'pdf',
  status text NOT NULL DEFAULT 'ready',
  summary text
);

CREATE TABLE public.marketing_audit_logs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  actor text NOT NULL,
  action text NOT NULL,
  entity_type text NOT NULL,
  entity_id text,
  entity_name text,
  ip_address text,
  module text NOT NULL DEFAULT 'marketing',
  details text,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE public.marketing_compliance_records (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  item text NOT NULL,
  regulation text NOT NULL,
  status text NOT NULL DEFAULT 'compliant',
  last_checked timestamptz NOT NULL DEFAULT now(),
  owner text,
  notes text
);

CREATE TABLE public.marketing_influencers (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  handle text NOT NULL,
  platform text NOT NULL,
  followers integer NOT NULL DEFAULT 0,
  engagement_rate numeric NOT NULL DEFAULT 0,
  category text,
  region text,
  status text NOT NULL DEFAULT 'active',
  campaigns_count integer NOT NULL DEFAULT 0,
  cost_per_post numeric NOT NULL DEFAULT 0,
  roi numeric NOT NULL DEFAULT 0
);

CREATE TABLE public.marketing_automations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  trigger_type text NOT NULL,
  channel text NOT NULL,
  status text NOT NULL DEFAULT 'active',
  audience_size integer NOT NULL DEFAULT 0,
  runs integer NOT NULL DEFAULT 0,
  conversions integer NOT NULL DEFAULT 0,
  last_run_at timestamptz,
  description text
);

CREATE TABLE public.marketing_templates (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  channel text NOT NULL,
  subject text,
  body text,
  category text,
  status text NOT NULL DEFAULT 'approved',
  usage_count integer NOT NULL DEFAULT 0
);

CREATE TABLE public.marketing_messages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  channel text NOT NULL,
  template_id uuid REFERENCES public.marketing_templates(id) ON DELETE SET NULL,
  campaign_id uuid REFERENCES public.marketing_campaigns(id) ON DELETE SET NULL,
  status text NOT NULL DEFAULT 'scheduled',
  sent integer NOT NULL DEFAULT 0,
  delivered integer NOT NULL DEFAULT 0,
  opened integer NOT NULL DEFAULT 0,
  clicked integer NOT NULL DEFAULT 0,
  bounced integer NOT NULL DEFAULT 0,
  scheduled_at timestamptz
);

CREATE TABLE public.marketing_social_posts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  platform text NOT NULL,
  content text NOT NULL,
  status text NOT NULL DEFAULT 'scheduled',
  scheduled_at timestamptz,
  published_at timestamptz,
  likes integer NOT NULL DEFAULT 0,
  comments integer NOT NULL DEFAULT 0,
  shares integer NOT NULL DEFAULT 0,
  reach integer NOT NULL DEFAULT 0,
  campaign_id uuid REFERENCES public.marketing_campaigns(id) ON DELETE SET NULL
);

CREATE TABLE public.marketing_regions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  country text NOT NULL DEFAULT 'India',
  state text,
  spend numeric NOT NULL DEFAULT 0,
  leads integer NOT NULL DEFAULT 0,
  conversions integer NOT NULL DEFAULT 0,
  revenue numeric NOT NULL DEFAULT 0,
  growth_rate numeric NOT NULL DEFAULT 0,
  status text NOT NULL DEFAULT 'active'
);

CREATE TABLE public.marketing_budgets (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  channel text NOT NULL,
  period text NOT NULL,
  allocated numeric NOT NULL DEFAULT 0,
  spent numeric NOT NULL DEFAULT 0,
  committed numeric NOT NULL DEFAULT 0,
  status text NOT NULL DEFAULT 'on_track',
  owner text
);

CREATE TABLE public.marketing_ai_recommendations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  category text NOT NULL,
  campaign_id uuid REFERENCES public.marketing_campaigns(id) ON DELETE SET NULL,
  recommendation text NOT NULL,
  impact_estimate text,
  confidence integer NOT NULL DEFAULT 0,
  status text NOT NULL DEFAULT 'new',
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE public.marketing_alerts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  severity text NOT NULL DEFAULT 'info',
  category text NOT NULL DEFAULT 'campaign',
  status text NOT NULL DEFAULT 'open',
  message text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  resolved_at timestamptz
);

DO $$
DECLARE t text;
BEGIN
  FOR t IN SELECT unnest(ARRAY[
    'marketing_campaigns','marketing_ad_groups','marketing_creatives','marketing_content_items',
    'marketing_seo_keywords','marketing_seo_pages','marketing_lead_sources','marketing_leads',
    'marketing_offers','marketing_locations','marketing_schedules','marketing_channel_performance',
    'marketing_kpi_snapshots','marketing_approvals','marketing_reports','marketing_audit_logs',
    'marketing_compliance_records','marketing_influencers','marketing_automations','marketing_templates',
    'marketing_messages','marketing_social_posts','marketing_regions','marketing_budgets',
    'marketing_ai_recommendations','marketing_alerts'])
  LOOP
    EXECUTE format('GRANT SELECT, INSERT, UPDATE, DELETE ON public.%I TO anon, authenticated', t);
    EXECUTE format('GRANT ALL ON public.%I TO service_role', t);
    EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY', t);
    EXECUTE format('CREATE POLICY "Marketing console full access" ON public.%I FOR ALL TO anon, authenticated USING (true) WITH CHECK (true)', t);
  END LOOP;
END $$;

INSERT INTO public.marketing_campaigns (code,name,channel,objective,status,start_date,end_date,budget,spend,impressions,clicks,conversions,leads,revenue,kpi_target,region,owner) VALUES
('CMP-2401','Software Vala ERP Launch','Google Ads','Lead Generation','active','2026-06-01','2026-08-31',850000,612400,4820000,138400,2140,3860,7420000,'4,000 qualified leads','West India','Ritika Sharma'),
('CMP-2402','Monsoon Franchise Drive','Meta Ads','Franchise Signups','active','2026-06-15','2026-09-15',540000,318900,3110000,96700,1180,2240,4180000,'2,500 franchise enquiries','Pan India','Arjun Mehta'),
('CMP-2403','Independence Day Offer','Email','Revenue','scheduled','2026-08-05','2026-08-20',180000,0,0,0,0,0,0,'12,000 redemptions','Pan India','Neha Kulkarni'),
('CMP-2404','Reseller Partner Push','LinkedIn Ads','Partner Acquisition','active','2026-05-10','2026-08-10',420000,376500,1240000,41800,690,1120,3560000,'900 partner leads','South India','Vikram Iyer'),
('CMP-2405','Retargeting — Abandoned Demos','Google Ads','Conversion','paused','2026-04-01','2026-07-31',260000,214300,1980000,72300,940,1310,2870000,'1,000 demo conversions','Pan India','Ritika Sharma'),
('CMP-2406','Influencer Wave — SMB Tech','Influencer','Brand Awareness','completed','2026-03-01','2026-04-30',380000,380000,6240000,151200,860,1640,3120000,'5M reach','Pan India','Sanjana Rao'),
('CMP-2407','WhatsApp Renewal Nudge','WhatsApp','Retention','active','2026-07-01','2026-09-30',95000,41200,412000,38900,1420,780,2940000,'1,500 renewals','Pan India','Arjun Mehta'),
('CMP-2408','SEO Content Engine Q3','Organic Search','Traffic','active','2026-07-01','2026-09-30','150000',88400,2260000,84500,510,1470,1980000,'120K organic sessions','Pan India','Neha Kulkarni');

INSERT INTO public.marketing_ad_groups (campaign_id,name,level,platform,status,budget,spend,impressions,clicks,conversions)
SELECT c.id, g.name, g.level, g.platform, g.status, g.budget, g.spend, g.impressions, g.clicks, g.conversions
FROM public.marketing_campaigns c
JOIN (VALUES
  ('CMP-2401','ERP — Exact Match Keywords','ad_group','Google Ads','active',320000,241800,1840000,58200,910),
  ('CMP-2401','ERP — Competitor Terms','ad_group','Google Ads','active',210000,164900,1120000,32400,480),
  ('CMP-2401','ERP — Remarketing Display','ad_group','Google Ads','paused',140000,98700,1860000,47800,750),
  ('CMP-2402','Franchise — Lookalike 2%','ad_set','Meta Ads','active',260000,168300,1720000,52100,640),
  ('CMP-2402','Franchise — Tier 2 Cities','ad_set','Meta Ads','active',180000,110400,1390000,44600,540),
  ('CMP-2404','Partners — Job Title Targeting','ad_group','LinkedIn Ads','active',240000,218700,720000,24300,410),
  ('CMP-2404','Partners — Company Size 50+','ad_group','LinkedIn Ads','active',180000,157800,520000,17500,280),
  ('CMP-2405','Demo Abandoners — 7 Day','ad_group','Google Ads','paused',160000,132100,1180000,43800,570)
) AS g(code,name,level,platform,status,budget,spend,impressions,clicks,conversions) ON g.code = c.code;

INSERT INTO public.marketing_creatives (name,asset_type,format,status,dimensions,tags,uploaded_by,performance_score,usage_count) VALUES
('ERP Launch Hero Banner','image','JPG','approved','1200x628','{"erp","launch","hero"}','Sanjana Rao',87,14),
('Franchise Explainer 30s','video','MP4','approved','1080x1080','{"franchise","explainer"}','Dev Patel',92,9),
('Independence Day Offer Story','image','PNG','in_review','1080x1920','{"festival","offer"}','Sanjana Rao',0,0),
('Reseller Deck 2026','document','PDF','approved','A4','{"reseller","sales"}','Vikram Iyer',74,22),
('WhatsApp Renewal Card','image','PNG','approved','1080x1080','{"retention","whatsapp"}','Neha Kulkarni',81,31),
('SMB Testimonial Reel','video','MP4','approved','1080x1920','{"testimonial","social"}','Dev Patel',95,17),
('Google Display Set — Blue','image','PNG','archived','300x250','{"display","remarketing"}','Sanjana Rao',58,40),
('Monsoon Campaign Carousel','image','JPG','approved','1080x1080','{"monsoon","carousel"}','Dev Patel',79,11);

INSERT INTO public.marketing_content_items (title,content_type,channel,status,scheduled_for,author,body,tags,word_count) VALUES
('How Indian SMBs Cut Billing Time by 60%','blog','Organic Search','published',now() - interval '9 days','Neha Kulkarni','Long-form case study covering billing automation outcomes across 42 retail clients.','{"seo","case-study"}',1840),
('GST-Ready Invoicing: 2026 Checklist','blog','Organic Search','published',now() - interval '4 days','Neha Kulkarni','Compliance checklist for GST invoicing updates effective FY26.','{"gst","compliance"}',1420),
('Franchise Owner Playbook','ebook','Email','scheduled',now() + interval '3 days','Arjun Mehta','12-chapter playbook for new franchise partners.','{"franchise","lead-magnet"}',6200),
('5 Signs Your Billing Software Is Costing You','social','LinkedIn','in_review',now() + interval '1 day','Sanjana Rao','Carousel copy for LinkedIn thought leadership.','{"social","awareness"}',320),
('Independence Day Offer Announcement','email','Email','draft',now() + interval '10 days','Neha Kulkarni','Announcement email for the 15 August offer window.','{"festival","promo"}',280),
('Customer Story — Shree Traders, Surat','case_study','Website','published',now() - interval '18 days','Sanjana Rao','Surat wholesaler scaled to 6 branches on Software Vala.','{"case-study","retail"}',1150),
('Reseller Onboarding Webinar Script','script','Webinar','approved',now() + interval '6 days','Vikram Iyer','45 minute webinar script with demo checkpoints.','{"reseller","webinar"}',2400);

INSERT INTO public.marketing_seo_keywords (keyword,page_url,position,previous_position,search_volume,difficulty,cpc,intent,status,country) VALUES
('billing software for small business','/products/billing',4,7,27100,62,84.50,'commercial','tracking','India'),
('gst invoicing software india','/products/gst-invoicing',2,3,18100,58,71.20,'commercial','tracking','India'),
('erp software for retail shop','/products/retail-erp',9,12,12400,66,96.80,'commercial','tracking','India'),
('franchise management software','/solutions/franchise',6,6,4400,49,112.40,'commercial','tracking','India'),
('best pos software india','/products/pos',13,18,22200,71,88.90,'commercial','opportunity','India'),
('inventory management app','/products/inventory',8,5,33100,64,62.30,'commercial','watch','India'),
('software vala','/',1,1,9900,12,14.60,'navigational','tracking','India'),
('cloud accounting software price','/pricing',15,21,8100,55,102.10,'transactional','opportunity','India'),
('whatsapp billing software','/products/whatsapp-billing',3,4,5400,43,58.70,'commercial','tracking','India'),
('reseller program software india','/partners/reseller',11,14,2900,38,74.00,'commercial','opportunity','India');

INSERT INTO public.marketing_seo_pages (url,title,meta_description,health_score,issues,backlinks,organic_traffic,indexed) VALUES
('/','Software Vala — Business Software for Indian SMBs','All-in-one billing, inventory and ERP platform built for Indian businesses.',94,1,1840,42800,true),
('/products/billing','Billing Software for Small Business','GST-ready billing with WhatsApp invoices and multi-branch support.',88,3,612,18900,true),
('/products/gst-invoicing','GST Invoicing Software India','File-ready GST invoicing with automated returns support.',91,2,438,14200,true),
('/products/retail-erp','Retail ERP Software','Complete retail ERP with POS, inventory and analytics.',72,9,204,6100,true),
('/solutions/franchise','Franchise Management Software','Manage every franchise branch from one console.',81,5,167,3980,true),
('/pricing','Pricing — Software Vala','Transparent pricing for billing, ERP and franchise plans.',69,11,298,9400,true),
('/partners/reseller','Reseller Partner Program','Earn recurring revenue as a Software Vala reseller.',77,6,121,2450,true);

INSERT INTO public.marketing_lead_sources (name,source_type,channel,leads_count,qualified_count,conversion_rate,cost_per_lead,status,region) VALUES
('Google Search Ads','paid','Google Ads',3860,1420,36.8,158.60,'active','Pan India'),
('Meta Lead Forms','paid','Meta Ads',2240,742,33.1,142.40,'active','Pan India'),
('Organic Search','organic','Organic Search',1470,588,40.0,60.10,'active','Pan India'),
('LinkedIn InMail','paid','LinkedIn Ads',1120,506,45.2,336.20,'active','South India'),
('WhatsApp Business','owned','WhatsApp',780,410,52.6,52.80,'active','Pan India'),
('Referral Partners','partner','Referral',640,388,60.6,0.00,'active','West India'),
('Webinars','owned','Webinar',392,214,54.6,214.30,'active','Pan India'),
('Trade Expos','offline','Events',268,131,48.9,682.50,'paused','North India');

INSERT INTO public.marketing_leads (full_name,email,phone,company,score,stage,status,city,state,assigned_to,source_id,campaign_id)
SELECT l.full_name,l.email,l.phone,l.company,l.score,l.stage,l.status,l.city,l.state,l.assigned_to,
  (SELECT id FROM public.marketing_lead_sources WHERE name = l.source),
  (SELECT id FROM public.marketing_campaigns WHERE code = l.code)
FROM (VALUES
  ('Rahul Deshmukh','rahul.deshmukh@shreetraders.in','+91 98200 41123','Shree Traders',86,'qualified','open','Surat','Gujarat','Priya Nair','Google Search Ads','CMP-2401'),
  ('Anita Verma','anita@vermaretail.com','+91 99870 22314','Verma Retail',72,'contacted','open','Indore','Madhya Pradesh','Karan Joshi','Meta Lead Forms','CMP-2402'),
  ('Suresh Pillai','suresh.pillai@kochifoods.in','+91 94470 55901','Kochi Foods',91,'demo_booked','open','Kochi','Kerala','Priya Nair','LinkedIn InMail','CMP-2404'),
  ('Meera Agarwal','meera@agarwaltextiles.co.in','+91 98110 76233','Agarwal Textiles',64,'new','open','Jaipur','Rajasthan','Karan Joshi','Organic Search','CMP-2408'),
  ('Imran Sheikh','imran@sheikhelectronics.in','+91 90040 18876','Sheikh Electronics',78,'qualified','open','Hyderabad','Telangana','Priya Nair','WhatsApp Business','CMP-2407'),
  ('Deepa Krishnan','deepa@krishnanmart.in','+91 98450 33210','Krishnan Mart',95,'proposal','open','Bengaluru','Karnataka','Rohit Sen','Referral Partners','CMP-2404'),
  ('Vivek Chauhan','vivek@chauhanautoparts.in','+91 99530 66412','Chauhan Autoparts',58,'contacted','open','Ludhiana','Punjab','Karan Joshi','Trade Expos','CMP-2402'),
  ('Sneha Patil','sneha@patilpharma.in','+91 98220 90184','Patil Pharma',83,'qualified','open','Pune','Maharashtra','Rohit Sen','Google Search Ads','CMP-2401'),
  ('Nikhil Bose','nikhil@boseandsons.in','+91 98300 71145','Bose & Sons',47,'new','open','Kolkata','West Bengal','Priya Nair','Webinars','CMP-2408'),
  ('Farhan Qureshi','farhan@qureshifurnish.in','+91 97120 45509','Qureshi Furnishings',69,'contacted','open','Lucknow','Uttar Pradesh','Rohit Sen','Meta Lead Forms','CMP-2402')
) AS l(full_name,email,phone,company,score,stage,status,city,state,assigned_to,source,code);

INSERT INTO public.marketing_offers (title,festival,offer_type,discount_percent,code,start_date,end_date,status,regions,redemptions,revenue) VALUES
('Independence Day Freedom Sale','Independence Day','discount',25,'FREEDOM25','2026-08-10','2026-08-20','scheduled','{"Pan India"}',0,0),
('Monsoon Starter Pack','Monsoon','bundle',15,'MONSOON15','2026-06-15','2026-09-15','active','{"West India","South India"}',1842,3184000),
('Ganesh Chaturthi Special','Ganesh Chaturthi','discount',20,'GANESH20','2026-09-05','2026-09-16','scheduled','{"West India"}',0,0),
('Diwali Mega Upgrade','Diwali','upgrade',30,'DIWALI30','2026-11-01','2026-11-15','draft','{"Pan India"}',0,0),
('Franchise Onboarding Waiver','None','fee_waiver',100,'FRANCHISE0','2026-05-01','2026-07-31','active','{"Pan India"}',214,0),
('Reseller Q3 Accelerator','None','commission',10,'RESELL10','2026-07-01','2026-09-30','active','{"South India"}',86,1420000);

INSERT INTO public.marketing_locations (name,location_type,country,state,city,radius_km,population,active_campaigns,spend,leads,status) VALUES
('Mumbai Metro','city','India','Maharashtra','Mumbai',45,20400000,5,184200,842,'active'),
('Pune','city','India','Maharashtra','Pune',30,7200000,4,96400,516,'active'),
('Surat','city','India','Gujarat','Surat',25,6900000,3,71800,438,'active'),
('Bengaluru Urban','city','India','Karnataka','Bengaluru',40,13600000,5,162700,791,'active'),
('Hyderabad','city','India','Telangana','Hyderabad',35,10500000,4,118300,604,'active'),
('Delhi NCR','city','India','Delhi','New Delhi',50,32200000,4,141900,688,'active'),
('Jaipur','city','India','Rajasthan','Jaipur',25,4100000,2,42600,247,'active'),
('Kochi','city','India','Kerala','Kochi',20,2300000,2,31400,186,'active'),
('Indore','city','India','Madhya Pradesh','Indore',22,3300000,2,28900,171,'paused'),
('Kolkata','city','India','West Bengal','Kolkata',35,14900000,3,64100,352,'active');

INSERT INTO public.marketing_schedules (campaign_id,title,channel,scheduled_at,recurrence,status,owner)
SELECT c.id, s.title, s.channel, s.scheduled_at, s.recurrence, s.status, s.owner
FROM public.marketing_campaigns c
JOIN (VALUES
  ('CMP-2403','Independence Day email blast','Email',now() + interval '6 days','once','scheduled','Neha Kulkarni'),
  ('CMP-2402','Monsoon creative refresh','Meta Ads',now() + interval '2 days','weekly','scheduled','Arjun Mehta'),
  ('CMP-2407','WhatsApp renewal batch — July','WhatsApp',now() + interval '1 day','monthly','scheduled','Arjun Mehta'),
  ('CMP-2401','Search budget pacing review','Google Ads',now() + interval '3 days','weekly','scheduled','Ritika Sharma'),
  ('CMP-2408','Blog publish — GST checklist','Organic Search',now() + interval '4 days','weekly','scheduled','Neha Kulkarni'),
  ('CMP-2404','LinkedIn partner webinar','LinkedIn Ads',now() + interval '9 days','once','scheduled','Vikram Iyer'),
  ('CMP-2406','Influencer report handover','Influencer',now() - interval '30 days','once','completed','Sanjana Rao'),
  ('CMP-2405','Retargeting audience rebuild','Google Ads',now() + interval '7 days','once','scheduled','Ritika Sharma')
) AS s(code,title,channel,scheduled_at,recurrence,status,owner) ON s.code = c.code;

INSERT INTO public.marketing_channel_performance (channel,period_start,period_end,spend,impressions,clicks,conversions,revenue,roas) VALUES
('Google Ads','2026-07-01','2026-07-31',826700,6800000,210700,3080,10290000,12.4),
('Meta Ads','2026-07-01','2026-07-31',318900,3110000,96700,1180,4180000,13.1),
('LinkedIn Ads','2026-07-01','2026-07-31',376500,1240000,41800,690,3560000,9.5),
('Email','2026-07-01','2026-07-31',48200,412000,38400,920,2140000,44.4),
('WhatsApp','2026-07-01','2026-07-31',41200,412000,38900,1420,2940000,71.4),
('Organic Search','2026-07-01','2026-07-31',88400,2260000,84500,510,1980000,22.4),
('Influencer','2026-07-01','2026-07-31',126000,2080000,50400,287,1040000,8.3);

INSERT INTO public.marketing_kpi_snapshots (metric_date,spend,reach,impressions,clicks,leads,conversions,revenue,roas,conversion_rate)
SELECT d::date,
  48000 + (random()*14000)::int,
  380000 + (random()*90000)::int,
  520000 + (random()*120000)::int,
  16000 + (random()*4200)::int,
  120 + (random()*60)::int,
  62 + (random()*34)::int,
  640000 + (random()*180000)::int,
  round((11 + random()*4)::numeric,2),
  round((3.8 + random()*1.6)::numeric,2)
FROM generate_series(current_date - interval '29 days', current_date, interval '1 day') d;

INSERT INTO public.marketing_approvals (item_type,item_name,requested_by,status,priority,approver,notes) VALUES
('Campaign','Independence Day Freedom Sale','Neha Kulkarni','pending','high','Ritika Sharma','Budget uplift of Rs 1.8L requested'),
('Creative','Independence Day Offer Story','Sanjana Rao','pending','medium','Ritika Sharma','Awaiting brand review'),
('Budget','Meta Ads Q3 top-up','Arjun Mehta','pending','high','Ritika Sharma','Rs 2.4L additional spend'),
('Content','Franchise Owner Playbook','Arjun Mehta','approved','medium','Ritika Sharma','Approved with minor copy edits'),
('Offer','Diwali Mega Upgrade','Neha Kulkarni','pending','low','Ritika Sharma','Draft pricing pending finance sign-off'),
('Campaign','Reseller Q3 Accelerator','Vikram Iyer','approved','medium','Ritika Sharma','Cleared for South India rollout'),
('Creative','Google Display Set — Blue','Sanjana Rao','rejected','low','Ritika Sharma','Off-brand colour palette');

INSERT INTO public.marketing_reports (name,report_type,period,generated_by,format,status,summary) VALUES
('Monthly Marketing Performance — July 2026','performance','July 2026','Ritika Sharma','pdf','ready','Spend Rs 18.3L, 3,860 leads, blended ROAS 12.4x'),
('Channel ROI Breakdown — Q2 FY26','roi','Q2 FY26','Ritika Sharma','xlsx','ready','WhatsApp and Email delivered highest ROAS'),
('SEO Visibility Report — July 2026','seo','July 2026','Neha Kulkarni','pdf','ready','Average position improved from 11.4 to 8.2'),
('Lead Source Attribution — July 2026','attribution','July 2026','Arjun Mehta','csv','ready','Paid search contributed 41% of qualified leads'),
('Franchise Campaign Review','campaign','June-July 2026','Arjun Mehta','pdf','generating','Compiling branch-level enquiry data'),
('Compliance & Consent Audit — Q2','compliance','Q2 FY26','Vikram Iyer','pdf','ready','All outbound lists consent-verified');

INSERT INTO public.marketing_audit_logs (actor,action,entity_type,entity_id,entity_name,ip_address,details) VALUES
('Ritika Sharma','campaign.budget_updated','Campaign','CMP-2401','Software Vala ERP Launch','103.21.58.14','Budget raised from Rs 7.2L to Rs 8.5L'),
('Arjun Mehta','campaign.paused','Campaign','CMP-2405','Retargeting — Abandoned Demos','103.21.58.29','Paused pending creative refresh'),
('Neha Kulkarni','content.published','Content','CNT-1182','GST-Ready Invoicing: 2026 Checklist','103.21.58.44','Published to blog and newsletter'),
('Sanjana Rao','creative.uploaded','Creative','CRV-3308','SMB Testimonial Reel','103.21.58.51','Uploaded 1080x1920 MP4'),
('Vikram Iyer','offer.created','Offer','OFR-556','Reseller Q3 Accelerator','103.21.58.77','10% commission accelerator for South India'),
('Ritika Sharma','approval.granted','Approval','APR-901','Franchise Owner Playbook','103.21.58.14','Approved with copy edits'),
('Arjun Mehta','automation.enabled','Automation','AUT-204','Demo No-Show Recovery','103.21.58.29','Enabled WhatsApp recovery journey'),
('Neha Kulkarni','seo.keyword_added','SEO','KW-7741','whatsapp billing software','103.21.58.44','Added to tracking set');

INSERT INTO public.marketing_compliance_records (item,regulation,status,owner,notes) VALUES
('Outbound email consent register','DPDP Act 2023','compliant','Vikram Iyer','Double opt-in enforced across all lists'),
('WhatsApp template approvals','Meta Business Policy','compliant','Arjun Mehta','All 14 templates approved'),
('SMS sender ID registration','TRAI DLT','compliant','Arjun Mehta','Header SVALA registered'),
('Influencer disclosure labels','ASCI Guidelines','attention','Sanjana Rao','2 posts missing #ad disclosure'),
('Ad claim substantiation','ASCI Guidelines','compliant','Ritika Sharma','Claims backed by client data'),
('Cookie consent banner','DPDP Act 2023','attention','Neha Kulkarni','Granular category toggles pending');

INSERT INTO public.marketing_influencers (name,handle,platform,followers,engagement_rate,category,region,status,campaigns_count,cost_per_post,roi) VALUES
('Tanvi Sheth','@tanvibuilds','Instagram',184000,4.8,'SMB Tech','West India','active',3,85000,4.2),
('Rohan Bhatt','@rohanonbusiness','YouTube',412000,3.1,'Business','Pan India','active',2,240000,3.6),
('Kavya Menon','@kavyacommerce','Instagram',96000,6.2,'Retail','South India','active',4,52000,5.4),
('Aditya Rana','@adityatechtalk','LinkedIn','58000',5.4,'Enterprise Tech','North India','active',1,68000,2.9),
('Priyanka Das','@priyankaretail','Instagram',132000,4.1,'Retail','East India','paused',1,61000,2.1),
('Manav Gupta','@manavgrowth','X','74000',2.7,'Startups','Pan India','active',2,38000,3.3);

INSERT INTO public.marketing_automations (name,trigger_type,channel,status,audience_size,runs,conversions,last_run_at,description) VALUES
('Demo No-Show Recovery','event','WhatsApp','active',1840,412,268,now() - interval '4 hours','Re-invites prospects who missed a scheduled demo'),
('Trial Day-3 Nudge','schedule','Email','active',3210,986,441,now() - interval '11 hours','Feature walkthrough on day 3 of trial'),
('Abandoned Pricing Page','behaviour','Google Ads','active',6420,1240,312,now() - interval '2 hours','Retargets pricing page visitors within 7 days'),
('Renewal T-30 Reminder','schedule','WhatsApp','active',940,214,178,now() - interval '1 day','Renewal reminder 30 days before expiry'),
('Franchise Enquiry Router','event','Internal','active',2240,2240,1120,now() - interval '20 minutes','Routes enquiries to nearest branch owner'),
('Lead Score Decay','schedule','Internal','paused',12800,52,0,now() - interval '9 days','Reduces score on inactive leads weekly');

INSERT INTO public.marketing_templates (name,channel,subject,body,category,status,usage_count) VALUES
('Welcome — New Trial','Email','Welcome to Software Vala','Hi {{name}}, your 14-day trial is live. Here is how to get started.','onboarding','approved',3840),
('Demo Reminder','WhatsApp',NULL,'Hi {{name}}, your Software Vala demo starts in 30 minutes. Join here: {{link}}','sales','approved',1240),
('Festival Offer Announcement','Email','{{festival}} offer inside — save {{discount}}%','Celebrate {{festival}} with {{discount}}% off every Software Vala plan.','promotion','approved',920),
('Renewal Reminder','SMS',NULL,'Your Software Vala plan expires on {{date}}. Renew now: {{link}}','retention','approved',2140),
('Franchise Enquiry Ack','WhatsApp',NULL,'Thanks {{name}}! Our franchise team from {{city}} will call you within 2 hours.','franchise','approved',2240),
('Reseller Monthly Digest','Email','Your {{month}} reseller payout summary','Here is your commission and pipeline summary for {{month}}.','partner','approved',480);

INSERT INTO public.marketing_messages (name,channel,campaign_id,status,sent,delivered,opened,clicked,bounced,scheduled_at)
SELECT m.name, m.channel, (SELECT id FROM public.marketing_campaigns WHERE code = m.code), m.status, m.sent, m.delivered, m.opened, m.clicked, m.bounced, m.scheduled_at
FROM (VALUES
  ('Independence Day Blast — Segment A','Email','CMP-2403','scheduled',0,0,0,0,0,now() + interval '6 days'),
  ('Monsoon Offer — Existing Clients','Email','CMP-2402','sent',18420,18104,7942,2186,316,now() - interval '12 days'),
  ('WhatsApp Renewal Batch — June','WhatsApp','CMP-2407','sent',2410,2388,2104,984,22,now() - interval '26 days'),
  ('Demo Reminder Drip — July','WhatsApp','CMP-2401','sent',3860,3812,3402,1640,48,now() - interval '5 days'),
  ('Reseller Digest — July','Email','CMP-2404','sent',482,478,341,168,4,now() - interval '8 days'),
  ('SMS Renewal Nudge — July','SMS','CMP-2407','sending',1420,1364,0,412,56,now() - interval '1 day')
) AS m(name,channel,code,status,sent,delivered,opened,clicked,bounced,scheduled_at);

INSERT INTO public.marketing_social_posts (platform,content,status,scheduled_at,published_at,likes,comments,shares,reach) VALUES
('LinkedIn','Shree Traders cut billing time by 60% after moving to Software Vala. Full story in comments.','published',now() - interval '6 days',now() - interval '6 days',842,64,118,48200),
('Instagram','Monsoon Starter Pack is live — 15% off every plan until 15 September.','published',now() - interval '3 days',now() - interval '3 days',2140,186,304,126400),
('X','GST invoicing updates for FY26 explained in 8 tweets.','published',now() - interval '9 days',now() - interval '9 days',312,28,96,18400),
('Instagram','Behind the scenes at our Pune franchise partner meet.','scheduled',now() + interval '2 days',NULL,0,0,0,0),
('LinkedIn','We are hiring channel partners across South India.','scheduled',now() + interval '4 days',NULL,0,0,0,0),
('Facebook','Independence Day Freedom Sale — 25% off, 10-20 August.','draft',NULL,NULL,0,0,0,0);

INSERT INTO public.marketing_regions (name,country,state,spend,leads,conversions,revenue,growth_rate,status) VALUES
('West India','India','Maharashtra',612400,1842,684,9840000,18.4,'active'),
('South India','India','Karnataka',498700,1416,542,7620000,22.1,'active'),
('North India','India','Delhi',341200,986,318,4180000,9.6,'active'),
('East India','India','West Bengal',186400,512,164,2140000,6.2,'active'),
('Central India','India','Madhya Pradesh',128900,384,121,1480000,4.8,'watch');

INSERT INTO public.marketing_budgets (name,channel,period,allocated,spent,committed,status,owner) VALUES
('Paid Search — Q3 FY26','Google Ads','Q3 FY26',1200000,826700,184000,'on_track','Ritika Sharma'),
('Paid Social — Q3 FY26','Meta Ads','Q3 FY26',600000,318900,96000,'on_track','Arjun Mehta'),
('LinkedIn — Q3 FY26','LinkedIn Ads','Q3 FY26',420000,376500,42000,'at_risk','Vikram Iyer'),
('Content & SEO — Q3 FY26','Organic Search','Q3 FY26',300000,88400,64000,'under_spent','Neha Kulkarni'),
('Influencer — Q3 FY26','Influencer','Q3 FY26',250000,126000,84000,'on_track','Sanjana Rao'),
('Messaging — Q3 FY26','WhatsApp','Q3 FY26',150000,41200,18000,'under_spent','Arjun Mehta');

INSERT INTO public.marketing_ai_recommendations (title,category,campaign_id,recommendation,impact_estimate,confidence,status)
SELECT r.title, r.category, (SELECT id FROM public.marketing_campaigns WHERE code = r.code), r.recommendation, r.impact_estimate, r.confidence, r.status
FROM (VALUES
  ('Shift 18% budget from Display to Search','budget','CMP-2401','Display CPA is 2.3x Search CPA over the last 14 days. Reallocate Rs 1.5L.','+312 conversions/month',88,'new'),
  ('Refresh Monsoon creative set','creative','CMP-2402','Frequency has crossed 4.1 with CTR down 22% week on week.','+0.9% CTR',82,'new'),
  ('Add 6 long-tail keywords','seo','CMP-2408','Six pricing-intent long-tails rank 11-20 with low difficulty.','+8.4K sessions/month',76,'new'),
  ('Pause Ludhiana geo for franchise ads','targeting','CMP-2402','Cost per enquiry is 2.7x the national average.','-Rs 42K wasted spend',91,'accepted'),
  ('Move renewal nudge to 10:30 IST','timing','CMP-2407','Open rate peaks between 10:00 and 11:00 IST.','+11% open rate',79,'new'),
  ('Bid up on competitor terms','bidding','CMP-2401','Impression share lost to rank is 34% on competitor set.','+180 leads/month',71,'dismissed')
) AS r(title,category,code,recommendation,impact_estimate,confidence,status);

INSERT INTO public.marketing_alerts (title,severity,category,status,message) VALUES
('LinkedIn budget 89% consumed','warning','budget','open','Q3 LinkedIn budget will exhaust in 6 days at current pace.'),
('Meta creative fatigue detected','warning','creative','open','Monsoon carousel frequency at 4.1 with falling CTR.'),
('2 influencer posts missing #ad','critical','compliance','open','ASCI disclosure missing on Priyanka Das posts from last week.'),
('Organic position gain','info','seo','open','erp software for retail shop moved from 12 to 9.'),
('Retargeting campaign paused','info','campaign','acknowledged','CMP-2405 paused pending creative refresh.'),
('WhatsApp delivery dip','warning','messaging','open','Delivery rate fell to 94.1% on the July renewal batch.');
