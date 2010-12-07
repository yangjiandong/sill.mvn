# Fat Free CRM
#------------------------------------------------------------------------------

module Sill
  module Callback
    @@classes   = []  # Classes that inherit from Sill::Callback::Base.
    @@responder = {}  # Class instances that respond to (i.e. implement) hook methods.

    # Adds a class inherited from from Sill::Callback::Base.
    #--------------------------------------------------------------------------
    def self.add(klass)
      @@classes << klass
    end

    # Finds class instance that responds to given method.
    #------------------------------------------------------------------------------
    def self.responder(method)
      @@responder[method] ||= @@classes.map { |klass| klass.instance }.select { |instance| instance.respond_to?(method) }
    end

    # Invokes the hook named :method and captures its output. The hook returns:
    # - empty array if no hook with this name was detected.
    # - array with single item returned by the hook.
    # - array with multiple items returned by the hook chain.
    #--------------------------------------------------------------------------
    def self.hook(method, caller, context = {})
      responder(method).inject([]) do |response, m|
        response << m.send(method, caller, context)
      end
    end

    #--------------------------------------------------------------------------
    class Base
      include Singleton

      def self.inherited(child)
        Sill::Callback.add(child)
        super
      end

    end # class Base

    # This makes it possible to call hook() without Sill::Callback prefix.
    # Returns stringified data when called from within templates, and the actual
    # data otherwise.
    #--------------------------------------------------------------------------
    module Helper
      def hook(method, caller, context = {})
        data = Sill::Callback.hook(method, caller, context)
        caller.is_haml? ? data.join.html_safe : data
      end
    end # module Helper

  end # module Callback
end # module Sill
