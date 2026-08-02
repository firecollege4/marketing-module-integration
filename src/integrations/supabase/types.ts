export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.15"
  }
  public: {
    Tables: {
      marketing_ad_groups: {
        Row: {
          budget: number
          campaign_id: string | null
          clicks: number
          conversions: number
          created_at: string
          id: string
          impressions: number
          level: string
          name: string
          platform: string
          spend: number
          status: string
        }
        Insert: {
          budget?: number
          campaign_id?: string | null
          clicks?: number
          conversions?: number
          created_at?: string
          id?: string
          impressions?: number
          level?: string
          name: string
          platform: string
          spend?: number
          status?: string
        }
        Update: {
          budget?: number
          campaign_id?: string | null
          clicks?: number
          conversions?: number
          created_at?: string
          id?: string
          impressions?: number
          level?: string
          name?: string
          platform?: string
          spend?: number
          status?: string
        }
        Relationships: [
          {
            foreignKeyName: "marketing_ad_groups_campaign_id_fkey"
            columns: ["campaign_id"]
            isOneToOne: false
            referencedRelation: "marketing_campaigns"
            referencedColumns: ["id"]
          },
        ]
      }
      marketing_ai_recommendations: {
        Row: {
          campaign_id: string | null
          category: string
          confidence: number
          created_at: string
          id: string
          impact_estimate: string | null
          recommendation: string
          status: string
          title: string
        }
        Insert: {
          campaign_id?: string | null
          category: string
          confidence?: number
          created_at?: string
          id?: string
          impact_estimate?: string | null
          recommendation: string
          status?: string
          title: string
        }
        Update: {
          campaign_id?: string | null
          category?: string
          confidence?: number
          created_at?: string
          id?: string
          impact_estimate?: string | null
          recommendation?: string
          status?: string
          title?: string
        }
        Relationships: [
          {
            foreignKeyName: "marketing_ai_recommendations_campaign_id_fkey"
            columns: ["campaign_id"]
            isOneToOne: false
            referencedRelation: "marketing_campaigns"
            referencedColumns: ["id"]
          },
        ]
      }
      marketing_alerts: {
        Row: {
          category: string
          created_at: string
          id: string
          message: string
          resolved_at: string | null
          severity: string
          status: string
          title: string
        }
        Insert: {
          category?: string
          created_at?: string
          id?: string
          message: string
          resolved_at?: string | null
          severity?: string
          status?: string
          title: string
        }
        Update: {
          category?: string
          created_at?: string
          id?: string
          message?: string
          resolved_at?: string | null
          severity?: string
          status?: string
          title?: string
        }
        Relationships: []
      }
      marketing_approvals: {
        Row: {
          approver: string | null
          decided_at: string | null
          id: string
          item_name: string
          item_type: string
          notes: string | null
          priority: string
          requested_at: string
          requested_by: string
          status: string
        }
        Insert: {
          approver?: string | null
          decided_at?: string | null
          id?: string
          item_name: string
          item_type: string
          notes?: string | null
          priority?: string
          requested_at?: string
          requested_by: string
          status?: string
        }
        Update: {
          approver?: string | null
          decided_at?: string | null
          id?: string
          item_name?: string
          item_type?: string
          notes?: string | null
          priority?: string
          requested_at?: string
          requested_by?: string
          status?: string
        }
        Relationships: []
      }
      marketing_audit_logs: {
        Row: {
          action: string
          actor: string
          created_at: string
          details: string | null
          entity_id: string | null
          entity_name: string | null
          entity_type: string
          id: string
          ip_address: string | null
          module: string
        }
        Insert: {
          action: string
          actor: string
          created_at?: string
          details?: string | null
          entity_id?: string | null
          entity_name?: string | null
          entity_type: string
          id?: string
          ip_address?: string | null
          module?: string
        }
        Update: {
          action?: string
          actor?: string
          created_at?: string
          details?: string | null
          entity_id?: string | null
          entity_name?: string | null
          entity_type?: string
          id?: string
          ip_address?: string | null
          module?: string
        }
        Relationships: []
      }
      marketing_automations: {
        Row: {
          audience_size: number
          channel: string
          conversions: number
          description: string | null
          id: string
          last_run_at: string | null
          name: string
          runs: number
          status: string
          trigger_type: string
        }
        Insert: {
          audience_size?: number
          channel: string
          conversions?: number
          description?: string | null
          id?: string
          last_run_at?: string | null
          name: string
          runs?: number
          status?: string
          trigger_type: string
        }
        Update: {
          audience_size?: number
          channel?: string
          conversions?: number
          description?: string | null
          id?: string
          last_run_at?: string | null
          name?: string
          runs?: number
          status?: string
          trigger_type?: string
        }
        Relationships: []
      }
      marketing_budgets: {
        Row: {
          allocated: number
          channel: string
          committed: number
          id: string
          name: string
          owner: string | null
          period: string
          spent: number
          status: string
        }
        Insert: {
          allocated?: number
          channel: string
          committed?: number
          id?: string
          name: string
          owner?: string | null
          period: string
          spent?: number
          status?: string
        }
        Update: {
          allocated?: number
          channel?: string
          committed?: number
          id?: string
          name?: string
          owner?: string | null
          period?: string
          spent?: number
          status?: string
        }
        Relationships: []
      }
      marketing_campaigns: {
        Row: {
          budget: number
          channel: string
          clicks: number
          code: string
          conversions: number
          created_at: string
          end_date: string
          id: string
          impressions: number
          kpi_target: string | null
          leads: number
          name: string
          objective: string
          owner: string | null
          region: string | null
          revenue: number
          spend: number
          start_date: string
          status: string
          updated_at: string
        }
        Insert: {
          budget?: number
          channel: string
          clicks?: number
          code: string
          conversions?: number
          created_at?: string
          end_date: string
          id?: string
          impressions?: number
          kpi_target?: string | null
          leads?: number
          name: string
          objective?: string
          owner?: string | null
          region?: string | null
          revenue?: number
          spend?: number
          start_date: string
          status?: string
          updated_at?: string
        }
        Update: {
          budget?: number
          channel?: string
          clicks?: number
          code?: string
          conversions?: number
          created_at?: string
          end_date?: string
          id?: string
          impressions?: number
          kpi_target?: string | null
          leads?: number
          name?: string
          objective?: string
          owner?: string | null
          region?: string | null
          revenue?: number
          spend?: number
          start_date?: string
          status?: string
          updated_at?: string
        }
        Relationships: []
      }
      marketing_channel_performance: {
        Row: {
          channel: string
          clicks: number
          conversions: number
          id: string
          impressions: number
          period_end: string
          period_start: string
          revenue: number
          roas: number
          spend: number
        }
        Insert: {
          channel: string
          clicks?: number
          conversions?: number
          id?: string
          impressions?: number
          period_end: string
          period_start: string
          revenue?: number
          roas?: number
          spend?: number
        }
        Update: {
          channel?: string
          clicks?: number
          conversions?: number
          id?: string
          impressions?: number
          period_end?: string
          period_start?: string
          revenue?: number
          roas?: number
          spend?: number
        }
        Relationships: []
      }
      marketing_compliance_records: {
        Row: {
          id: string
          item: string
          last_checked: string
          notes: string | null
          owner: string | null
          regulation: string
          status: string
        }
        Insert: {
          id?: string
          item: string
          last_checked?: string
          notes?: string | null
          owner?: string | null
          regulation: string
          status?: string
        }
        Update: {
          id?: string
          item?: string
          last_checked?: string
          notes?: string | null
          owner?: string | null
          regulation?: string
          status?: string
        }
        Relationships: []
      }
      marketing_content_items: {
        Row: {
          author: string | null
          body: string | null
          channel: string
          content_type: string
          created_at: string
          id: string
          scheduled_for: string | null
          status: string
          tags: string[]
          title: string
          word_count: number
        }
        Insert: {
          author?: string | null
          body?: string | null
          channel: string
          content_type: string
          created_at?: string
          id?: string
          scheduled_for?: string | null
          status?: string
          tags?: string[]
          title: string
          word_count?: number
        }
        Update: {
          author?: string | null
          body?: string | null
          channel?: string
          content_type?: string
          created_at?: string
          id?: string
          scheduled_for?: string | null
          status?: string
          tags?: string[]
          title?: string
          word_count?: number
        }
        Relationships: []
      }
      marketing_creatives: {
        Row: {
          asset_type: string
          campaign_id: string | null
          created_at: string
          dimensions: string | null
          format: string
          id: string
          name: string
          performance_score: number
          status: string
          tags: string[]
          uploaded_by: string | null
          usage_count: number
        }
        Insert: {
          asset_type: string
          campaign_id?: string | null
          created_at?: string
          dimensions?: string | null
          format: string
          id?: string
          name: string
          performance_score?: number
          status?: string
          tags?: string[]
          uploaded_by?: string | null
          usage_count?: number
        }
        Update: {
          asset_type?: string
          campaign_id?: string | null
          created_at?: string
          dimensions?: string | null
          format?: string
          id?: string
          name?: string
          performance_score?: number
          status?: string
          tags?: string[]
          uploaded_by?: string | null
          usage_count?: number
        }
        Relationships: [
          {
            foreignKeyName: "marketing_creatives_campaign_id_fkey"
            columns: ["campaign_id"]
            isOneToOne: false
            referencedRelation: "marketing_campaigns"
            referencedColumns: ["id"]
          },
        ]
      }
      marketing_influencers: {
        Row: {
          campaigns_count: number
          category: string | null
          cost_per_post: number
          engagement_rate: number
          followers: number
          handle: string
          id: string
          name: string
          platform: string
          region: string | null
          roi: number
          status: string
        }
        Insert: {
          campaigns_count?: number
          category?: string | null
          cost_per_post?: number
          engagement_rate?: number
          followers?: number
          handle: string
          id?: string
          name: string
          platform: string
          region?: string | null
          roi?: number
          status?: string
        }
        Update: {
          campaigns_count?: number
          category?: string | null
          cost_per_post?: number
          engagement_rate?: number
          followers?: number
          handle?: string
          id?: string
          name?: string
          platform?: string
          region?: string | null
          roi?: number
          status?: string
        }
        Relationships: []
      }
      marketing_kpi_snapshots: {
        Row: {
          clicks: number
          conversion_rate: number
          conversions: number
          id: string
          impressions: number
          leads: number
          metric_date: string
          reach: number
          revenue: number
          roas: number
          spend: number
        }
        Insert: {
          clicks?: number
          conversion_rate?: number
          conversions?: number
          id?: string
          impressions?: number
          leads?: number
          metric_date: string
          reach?: number
          revenue?: number
          roas?: number
          spend?: number
        }
        Update: {
          clicks?: number
          conversion_rate?: number
          conversions?: number
          id?: string
          impressions?: number
          leads?: number
          metric_date?: string
          reach?: number
          revenue?: number
          roas?: number
          spend?: number
        }
        Relationships: []
      }
      marketing_lead_sources: {
        Row: {
          channel: string
          conversion_rate: number
          cost_per_lead: number
          created_at: string
          id: string
          leads_count: number
          name: string
          qualified_count: number
          region: string | null
          source_type: string
          status: string
        }
        Insert: {
          channel: string
          conversion_rate?: number
          cost_per_lead?: number
          created_at?: string
          id?: string
          leads_count?: number
          name: string
          qualified_count?: number
          region?: string | null
          source_type: string
          status?: string
        }
        Update: {
          channel?: string
          conversion_rate?: number
          cost_per_lead?: number
          created_at?: string
          id?: string
          leads_count?: number
          name?: string
          qualified_count?: number
          region?: string | null
          source_type?: string
          status?: string
        }
        Relationships: []
      }
      marketing_leads: {
        Row: {
          assigned_to: string | null
          campaign_id: string | null
          city: string | null
          company: string | null
          created_at: string
          email: string | null
          full_name: string
          id: string
          phone: string | null
          score: number
          source_id: string | null
          stage: string
          state: string | null
          status: string
        }
        Insert: {
          assigned_to?: string | null
          campaign_id?: string | null
          city?: string | null
          company?: string | null
          created_at?: string
          email?: string | null
          full_name: string
          id?: string
          phone?: string | null
          score?: number
          source_id?: string | null
          stage?: string
          state?: string | null
          status?: string
        }
        Update: {
          assigned_to?: string | null
          campaign_id?: string | null
          city?: string | null
          company?: string | null
          created_at?: string
          email?: string | null
          full_name?: string
          id?: string
          phone?: string | null
          score?: number
          source_id?: string | null
          stage?: string
          state?: string | null
          status?: string
        }
        Relationships: [
          {
            foreignKeyName: "marketing_leads_campaign_id_fkey"
            columns: ["campaign_id"]
            isOneToOne: false
            referencedRelation: "marketing_campaigns"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "marketing_leads_source_id_fkey"
            columns: ["source_id"]
            isOneToOne: false
            referencedRelation: "marketing_lead_sources"
            referencedColumns: ["id"]
          },
        ]
      }
      marketing_locations: {
        Row: {
          active_campaigns: number
          city: string | null
          country: string
          id: string
          leads: number
          location_type: string
          name: string
          population: number
          radius_km: number
          spend: number
          state: string | null
          status: string
        }
        Insert: {
          active_campaigns?: number
          city?: string | null
          country?: string
          id?: string
          leads?: number
          location_type?: string
          name: string
          population?: number
          radius_km?: number
          spend?: number
          state?: string | null
          status?: string
        }
        Update: {
          active_campaigns?: number
          city?: string | null
          country?: string
          id?: string
          leads?: number
          location_type?: string
          name?: string
          population?: number
          radius_km?: number
          spend?: number
          state?: string | null
          status?: string
        }
        Relationships: []
      }
      marketing_messages: {
        Row: {
          bounced: number
          campaign_id: string | null
          channel: string
          clicked: number
          delivered: number
          id: string
          name: string
          opened: number
          scheduled_at: string | null
          sent: number
          status: string
          template_id: string | null
        }
        Insert: {
          bounced?: number
          campaign_id?: string | null
          channel: string
          clicked?: number
          delivered?: number
          id?: string
          name: string
          opened?: number
          scheduled_at?: string | null
          sent?: number
          status?: string
          template_id?: string | null
        }
        Update: {
          bounced?: number
          campaign_id?: string | null
          channel?: string
          clicked?: number
          delivered?: number
          id?: string
          name?: string
          opened?: number
          scheduled_at?: string | null
          sent?: number
          status?: string
          template_id?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "marketing_messages_campaign_id_fkey"
            columns: ["campaign_id"]
            isOneToOne: false
            referencedRelation: "marketing_campaigns"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "marketing_messages_template_id_fkey"
            columns: ["template_id"]
            isOneToOne: false
            referencedRelation: "marketing_templates"
            referencedColumns: ["id"]
          },
        ]
      }
      marketing_offers: {
        Row: {
          code: string | null
          created_at: string
          discount_percent: number
          end_date: string
          festival: string | null
          id: string
          offer_type: string
          redemptions: number
          regions: string[]
          revenue: number
          start_date: string
          status: string
          title: string
        }
        Insert: {
          code?: string | null
          created_at?: string
          discount_percent?: number
          end_date: string
          festival?: string | null
          id?: string
          offer_type?: string
          redemptions?: number
          regions?: string[]
          revenue?: number
          start_date: string
          status?: string
          title: string
        }
        Update: {
          code?: string | null
          created_at?: string
          discount_percent?: number
          end_date?: string
          festival?: string | null
          id?: string
          offer_type?: string
          redemptions?: number
          regions?: string[]
          revenue?: number
          start_date?: string
          status?: string
          title?: string
        }
        Relationships: []
      }
      marketing_regions: {
        Row: {
          conversions: number
          country: string
          growth_rate: number
          id: string
          leads: number
          name: string
          revenue: number
          spend: number
          state: string | null
          status: string
        }
        Insert: {
          conversions?: number
          country?: string
          growth_rate?: number
          id?: string
          leads?: number
          name: string
          revenue?: number
          spend?: number
          state?: string | null
          status?: string
        }
        Update: {
          conversions?: number
          country?: string
          growth_rate?: number
          id?: string
          leads?: number
          name?: string
          revenue?: number
          spend?: number
          state?: string | null
          status?: string
        }
        Relationships: []
      }
      marketing_reports: {
        Row: {
          format: string
          generated_at: string
          generated_by: string | null
          id: string
          name: string
          period: string
          report_type: string
          status: string
          summary: string | null
        }
        Insert: {
          format?: string
          generated_at?: string
          generated_by?: string | null
          id?: string
          name: string
          period: string
          report_type: string
          status?: string
          summary?: string | null
        }
        Update: {
          format?: string
          generated_at?: string
          generated_by?: string | null
          id?: string
          name?: string
          period?: string
          report_type?: string
          status?: string
          summary?: string | null
        }
        Relationships: []
      }
      marketing_schedules: {
        Row: {
          campaign_id: string | null
          channel: string
          id: string
          owner: string | null
          recurrence: string
          scheduled_at: string
          status: string
          title: string
        }
        Insert: {
          campaign_id?: string | null
          channel: string
          id?: string
          owner?: string | null
          recurrence?: string
          scheduled_at: string
          status?: string
          title: string
        }
        Update: {
          campaign_id?: string | null
          channel?: string
          id?: string
          owner?: string | null
          recurrence?: string
          scheduled_at?: string
          status?: string
          title?: string
        }
        Relationships: [
          {
            foreignKeyName: "marketing_schedules_campaign_id_fkey"
            columns: ["campaign_id"]
            isOneToOne: false
            referencedRelation: "marketing_campaigns"
            referencedColumns: ["id"]
          },
        ]
      }
      marketing_seo_keywords: {
        Row: {
          country: string
          cpc: number
          difficulty: number
          id: string
          intent: string
          keyword: string
          page_url: string | null
          position: number
          previous_position: number
          search_volume: number
          status: string
          updated_at: string
        }
        Insert: {
          country?: string
          cpc?: number
          difficulty?: number
          id?: string
          intent?: string
          keyword: string
          page_url?: string | null
          position?: number
          previous_position?: number
          search_volume?: number
          status?: string
          updated_at?: string
        }
        Update: {
          country?: string
          cpc?: number
          difficulty?: number
          id?: string
          intent?: string
          keyword?: string
          page_url?: string | null
          position?: number
          previous_position?: number
          search_volume?: number
          status?: string
          updated_at?: string
        }
        Relationships: []
      }
      marketing_seo_pages: {
        Row: {
          backlinks: number
          health_score: number
          id: string
          indexed: boolean
          issues: number
          last_crawled: string
          meta_description: string | null
          organic_traffic: number
          title: string
          url: string
        }
        Insert: {
          backlinks?: number
          health_score?: number
          id?: string
          indexed?: boolean
          issues?: number
          last_crawled?: string
          meta_description?: string | null
          organic_traffic?: number
          title: string
          url: string
        }
        Update: {
          backlinks?: number
          health_score?: number
          id?: string
          indexed?: boolean
          issues?: number
          last_crawled?: string
          meta_description?: string | null
          organic_traffic?: number
          title?: string
          url?: string
        }
        Relationships: []
      }
      marketing_social_posts: {
        Row: {
          campaign_id: string | null
          comments: number
          content: string
          id: string
          likes: number
          platform: string
          published_at: string | null
          reach: number
          scheduled_at: string | null
          shares: number
          status: string
        }
        Insert: {
          campaign_id?: string | null
          comments?: number
          content: string
          id?: string
          likes?: number
          platform: string
          published_at?: string | null
          reach?: number
          scheduled_at?: string | null
          shares?: number
          status?: string
        }
        Update: {
          campaign_id?: string | null
          comments?: number
          content?: string
          id?: string
          likes?: number
          platform?: string
          published_at?: string | null
          reach?: number
          scheduled_at?: string | null
          shares?: number
          status?: string
        }
        Relationships: [
          {
            foreignKeyName: "marketing_social_posts_campaign_id_fkey"
            columns: ["campaign_id"]
            isOneToOne: false
            referencedRelation: "marketing_campaigns"
            referencedColumns: ["id"]
          },
        ]
      }
      marketing_templates: {
        Row: {
          body: string | null
          category: string | null
          channel: string
          id: string
          name: string
          status: string
          subject: string | null
          usage_count: number
        }
        Insert: {
          body?: string | null
          category?: string | null
          channel: string
          id?: string
          name: string
          status?: string
          subject?: string | null
          usage_count?: number
        }
        Update: {
          body?: string | null
          category?: string | null
          channel?: string
          id?: string
          name?: string
          status?: string
          subject?: string | null
          usage_count?: number
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {},
  },
} as const
